path="/opt/osi/monarch/log/eitk"

if [ ! -e $path/folder1/file1.txt] || [ ! -e $path/file3.txt] || [ -e $path/folder2/file2.txt] || [ -e $path/file4.txt ]
then
    echo "Success"
    exit 0
else
    echo "Fail"
    exit 1
fi