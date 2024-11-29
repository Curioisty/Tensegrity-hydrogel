for i in `seq 1 3`; do
 
    echo A$i
   rm -r -f A$i
   mkdir A$i

   cd A$i
   
   cp -r ../../step1/A$i/polymer1.txt .
   cp -r ../../step1/A$i/jieguo2.lammpstrj .
 
   cp polymer1.txt  tmp2.txt

   head -n 16        polymer1.txt >  polymer2.txt
   tail -n 982399    jieguo2.lammpstrj  >>  polymer2.txt
   sed -i '1,982415d'  tmp2.txt 
   cat tmp2.txt >>  polymer2.txt
   
   rm -r -f *.data jieguo*.lammpstrj  
   cd ..

 done

