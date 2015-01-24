#!/bin/bash
# set -ev
hyphenToTitleCase() { 
    tr '-' '\n' | awk '{printf "%s%s", toupper(substr($0,0,1)), substr($0,2)}';
}
files=$(git log -m -1 --name-only --pretty="format:" ${TRAVIS_COMMIT});

# check if numbers of files is 2
modified_files=$(echo $files | wc -w | sed -e 's/^ *//' -e 's/ *$//' ); #trim it
echo "- Commit contains $modified_files file(s)";
if [[ $modified_files -ne "2" ]]; then
  echo "More than 2 files in the PR.";
  exit 1;
fi

# split by space
post=$(echo $files | cut -f1 -d\ );
echo "- Post path: $post";
screenshot=$(echo $files | cut -f2 -d\ );
echo "- Screenshot path: $screenshot";

# test filename == xxxx-xx-xx-.*\.md
match=$(echo $post | grep -o "_posts/xxxx-xx-xx-.*\.md");
if [[ $match != $post ]]; then
  echo "$post does not match the pattern \"_posts/xxxx-xx-.*\.md\"";
  exit 1;
fi

# test _post file content

# layout == post
match=$(grep -o "layout:\ *post" $post);
if [[ $match == "" ]]; then
  echo "Incorrect layout. Should be \"post\".";
  exit 1;
fi

# slug == filename
match=$(grep "slug:.*" $post | sed "s/slug:\ *\(.*\)$/_posts\/xxxx-xx-xx-\1.md/");
if [[ $match != $post ]]; then
  echo "The slug should match the filename.";
  exit 1;
fi

# title is Tile Cased
correct_title=$(grep "slug:.*" $post | sed "s/slug:\ *//" | hyphenToTitleCase);
actual_title=$(grep "title:.*" $post | sed "s/title:\ *\"\(.*\)\"$/\1/");
if [[ $correct_title != $actual_title ]]; then
  echo "Title should be the title cased slug.";
  exit 1;
fi

# img tag matches the screenshot name
path=$(grep "<img src=\"/screenshots/.*\">$" $post | sed "s/<img src=\"\/\(.*\)\">$/\1/");
if [[ ! -f $path ]]; then
  echo "$path not found!";
  exit 1;
fi

if [[ $path != $screenshot ]]; then
  echo "The path in the post img tag doesn't match the filename.";
  exit 1;
fi

# img is 1000 x 800
size="1000 x 800";
actual_size=$(file $screenshot | grep -o "$size");
if [[ $size != $actual_size ]]; then
  echo "Size of the image should be $size px.";
  exit 1;
fi

# test if website is up
source=$(grep "source:.*" $post | sed "s/source:\ *//");
if ! curl -s --head  --request GET $source | grep "200 OK" > /dev/null; then
    echo "$source didn't respond 200 OK."
    exit 1;
fi

echo "";
echo "All tests passed!"
echo "";
exit 0;
