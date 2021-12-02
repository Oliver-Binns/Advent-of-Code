for file in $(find . -name "*.swift"); do 
  directory=$(dirname $file)  
  filename=$(basename $file)
  echo ""
  (cd $directory && swift $filename)
done
