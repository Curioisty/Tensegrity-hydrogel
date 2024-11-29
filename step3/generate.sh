for i in `seq 1 3`; do
 
    echo A$i
   rm -r -f A$i
   mkdir A$i

   cd A$i
   
  cp -r ../../../step2_d4/A$i/a10.data   tmp1.txt
   
   cp -r tmp1.txt tmp2.txt
   
   sed -i '1,36d' tmp1.txt
   head -n  982402  tmp1.txt > tmp3.txt




   head -n  9    tmp2.txt >  polymer3.txt
   echo  "0 100 xlo xhi" >> polymer3.txt
   echo  "0 100 ylo yhi" >> polymer3.txt
   echo  "0 100 zlo zhi" >> polymer3.txt
   awk '{print $1, $2, $3, $4, $5, $6}' tmp3.txt  >> polymer3.txt
   sed -i '1,1964840d'  tmp2.txt 
   cat tmp2.txt          >> polymer3.txt
   
   rm -r -f *.data jieguo*.lammpstrj   
   cd ..

 done

