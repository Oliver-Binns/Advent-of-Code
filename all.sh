for file in $(find . -name "*.swift" | sort -n); do 
  directory=$(dirname $file)  
  filename=$(basename $file)
  echo ""
  (cd $directory && swift $filename)
done
