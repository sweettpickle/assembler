touch $1.asm
{
echo 'Assume CS:Code;, DS:Code'
echo 'Code Segment'
echo 'org 100h'
echo 'Start:'
echo '\n\n'
echo 'Code ends'
echo 'end Start'
} > $1.asm

touch build.bat
echo -n '..\\tasm ' > build.bat
echo $1.asm >> build.bat
echo -n '..\\tlink ' >> build.bat
echo /t /x $1.obj >> build.bat

touch db.bat
echo -n '..\\AFDPRO ' > db.bat
echo $1.COM >> db.bat
