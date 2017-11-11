#/bin/bash
./script5.sh | awk '
BEGIN{
	PPID=0
	Average=0
	Count=1
} 
{
if ($5 == PPID) 
{
	print $0;
	Average=Average+$8;
	Count=Count+1;
}else 
{
	print "Average_Sleeping_Children_of_ParentID= ", PPID, " is ", Average/Count;
	Average=$8;
	Count=1;
	PPID=$5
	print $0
}}
END{
	print "Average_Sleeping_Children_of_ParentID= ", PPID, " is ", Average/Count;
} '
