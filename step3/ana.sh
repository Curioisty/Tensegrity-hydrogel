  
   let i=5
 
    echo a$i 
   rm -r -f tmp*  atom*.txt  bond*.txt
 
   cp ../A3/a${i}.data  tmp1.txt

   sed -i '1,39d' tmp1.txt
   head -n  982399  tmp1.txt > tmp3.txt
   awk '{print $1, $4, $5, $6}' tmp3.txt  > atom$i.txt

   sed -i '1,1964800d'  tmp1.txt
   awk 'NF==4 && $2==1' tmp1.txt  > bond$i.txt


