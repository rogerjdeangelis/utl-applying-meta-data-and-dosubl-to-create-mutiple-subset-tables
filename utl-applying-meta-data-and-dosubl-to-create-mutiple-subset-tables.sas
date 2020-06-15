SAS Forum: Applying meta data and dosubl to create mutiple subset tables                                                           
                                                                                                                                   
github                                                                                                                             
https://tinyurl.com/yd5hl3bq                                                                                                       
https://github.com/rogerjdeangelis/utl-applying-meta-data-and-dosubl-to-create-mutiple-subset-tables                               
                                                                                                                                   
SAS Forum                                                                                                                          
https://tinyurl.com/y9gmvht4                                                                                                       
https://communities.sas.com/t5/SAS-Programming/Fetching-dates-from-an-external-table-for-use-in-Proc-SQL/m-p/658903                
                                                                                                                                   
This code is easier to maitain?                                                                                                    
                                                                                                                                   
*_                   _                                                                                                             
(_)_ __  _ __  _   _| |_                                                                                                           
| | '_ \| '_ \| | | | __|                                                                                                          
| | | | | |_) | |_| | |_                                                                                                           
|_|_| |_| .__/ \__,_|\__|                                                                                                          
        |_|                                                                                                                        
;                                                                                                                                  
                                                                                                                                   
data meta ;                                                                                                                        
  format dteBeg date7. dteEnd date7.;                                                                                              
  input table$ dteBeg date7. dteEnd date7.;                                                                                        
cards4;                                                                                                                            
cust1 21Jan20 28FEB20                                                                                                              
cust2 18Feb20 03Mar20                                                                                                              
cust3 13Feb20 22Feb20                                                                                                              
;;;;                                                                                                                               
run;quit;                                                                                                                          
                                                                                                                                   
data result;                                                                                                                       
 input name$ value numbered;                                                                                                       
cards4;                                                                                                                            
COLOR 6 2                                                                                                                          
CODER 4 1                                                                                                                          
ORDER 2 3                                                                                                                          
;;;;                                                                                                                               
run;quit;                                                                                                                          
                                                                                                                                   
data sample;                                                                                                                       
 format date date7.;                                                                                                               
 input numbered 2. date date7. area;                                                                                               
cards4;                                                                                                                            
2 22Jan20 1                                                                                                                        
2 20Jan20 5                                                                                                                        
5 18Feb20 6                                                                                                                        
2 14Feb20 8                                                                                                                        
1 18Feb20 9                                                                                                                        
;;;;                                                                                                                               
run;quit;                                                                                                                          
                                                                                                                                   
META total obs=3                                                                                                                   
                                                                                                                                   
Obs    DTEBEG     DTEEND     TABLE                                                                                                 
                                                                                                                                   
 1     21JAN20    28FEB02    cust1                                                                                                 
 2     18FEB20    03MAR02    cust2                                                                                                 
 3     13FEB20    22FEB02    cust3                                                                                                 
                                                                                                                                   
                                                                                                                                   
Up to 40 obs WORK.RESULT total obs=3                                                                                               
                                                                                                                                   
Obs    NAME     VALUE    NUMBERED                                                                                                  
                                                                                                                                   
 1     COLOR      6          2                                                                                                     
 2     CODER      4          1                                                                                                     
 3     ORDER      2          3                                                                                                     
                                                                                                                                   
SAMPLE total obs=5                                                                                                                 
                                                                                                                                   
Obs     DATE      NUMBERED    AREA                                                                                                 
                                                                                                                                   
 1     22JAN20        2         1                                                                                                  
 2     20JAN20        2         5                                                                                                  
 3     18FEB20        5         6                                                                                                  
 4     14FEB20        2         8                                                                                                  
 5     18FEB20        1         9                                                                                                  
                                                                                                                                   
*           _                                                                                                                      
 _ __ _   _| | ___                                                                                                                 
| '__| | | | |/ _ \                                                                                                                
| |  | |_| | |  __/                                                                                                                
|_|   \__,_|_|\___|                                                                                                                
;                                                                                                                                  
                                                                                                                                   
for # in record 1, 2 and 3 of meta                                                                                                 
                                                                                                                                   
   Create                                                                                                                          
      tables cust# as                                                                                                              
   select                                                                                                                          
      result.name                                                                                                                  
     ,result.numbered                                                                                                              
     ,sample.area                                                                                                                  
   from                                                                                                                            
     result,  sample                                                                                                               
   where                                                                                                                           
     result.numbered = sample.numbered and                                                                                         
     sample.date between meta# date_begin and meta#date_end                                                                        
                                                                                                                                   
*            _               _                                                                                                     
  ___  _   _| |_ _ __  _   _| |_                                                                                                   
 / _ \| | | | __| '_ \| | | | __|                                                                                                  
| (_) | |_| | |_| |_) | |_| | |_                                                                                                   
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                  
                |_|                                                                                                                
;                                                                                                                                  
                                                                                                                                   
/*                                                                                                                                 
   Given the first meta record, we require                                                                                         
   result.numbered = sample.numbered                                                                                               
   and sample.date between 21JAN20 and 28FEB02                                                                                     
   only the first record of sample amd result                                                                                      
   satisfy these conditions                                                                                                        
*/                                                                                                                                 
                                                                                                                                   
                                                                                                                                   
LOG total obs=3                                                                                                                    
                                                                                                                                   
  DTEBEG     DTEEND     TABLE              STATUS                                                                                  
                                                                                                                                   
  21JAN20    28FEB02    cust1    cust1 created sucsessfully                                                                        
  18FEB20    03MAR02    cust2    cust2 created sucsessfully                                                                        
  13FEB20    22FEB02    cust3    cust3 created sucsessfully                                                                        
                                                                                                                                   
                                                                                                                                   
WORK.CUST1 total obs=1                                                                                                             
                                                                                                                                   
Obs    NAME     NUMBERED    AREA                                                                                                   
                                                                                                                                   
 1     COLOR        2         5                                                                                                    
                                                                                                                                   
WORK.CUST2 total obs=4                                                                                                             
                                                                                                                                   
Obs    NAME     NUMBERED    AREA                                                                                                   
                                                                                                                                   
 1     COLOR        2         1                                                                                                    
 2     COLOR        2         8                                                                                                    
 3     COLOR        2         5                                                                                                    
                                                                                                                                   
 4     CODER        1         9                                                                                                    
                                                                                                                                   
WORK.CUST3 total obs=2                                                                                                             
                                                                                                                                   
 Obs    NAME     NUMBERED    AREA                                                                                                  
                                                                                                                                   
  1     COLOR        2         1                                                                                                   
  2     COLOR        2         5                                                                                                   
                                                                                                                                   
*                                                                                                                                  
 _ __  _ __ ___   ___ ___  ___ ___                                                                                                 
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                                                
| |_) | | | (_) | (_|  __/\__ \__ \                                                                                                
| .__/|_|  \___/ \___\___||___/___/                                                                                                
|_|                                                                                                                                
;                                                                                                                                  
                                                                                                                                   
* as a precaution;                                                                                                                 
%symdel table dteBeg dteEnd cc/ nowarn;                                                                                            
                                                                                                                                   
data log;                                                                                                                          
                                                                                                                                   
  set meta ;                                                                                                                       
                                                                                                                                   
  call symputx('table',table);                                                                                                     
  call symputx('dteBeg',dteBeg);                                                                                                   
  call symputx('dteEnd',dteEnd);                                                                                                   
                                                                                                                                   
  rc=dosubl('                                                                                                                      
        proc sql;                                                                                                                  
          create                                                                                                                   
             table &table as                                                                                                       
          select                                                                                                                   
             l.name                                                                                                                
            ,l.numbered                                                                                                            
            ,r.area                                                                                                                
          from                                                                                                                     
             result as l, sample as r                                                                                              
          where                                                                                                                    
             l.numbered = r.numbered and                                                                                           
             r.date between &dteBeg and &dteEnd                                                                                    
        ;quit;                                                                                                                     
                                                                                                                                   
        %let cc=&syserr;                                                                                                           
                                                                                                                                   
        ');                                                                                                                        
  if symgetn('cc')=0 then status = catx(" ",table,"created sucsessfully     ");                                                    
  else status = catx(" ",table,"failed to be created");                                                                            
                                                                                                                                   
  drop rc;                                                                                                                         
                                                                                                                                   
  output;                                                                                                                          
                                                                                                                                   
run;quit;                                                                                                                          
                                                                                                                                   
*                                 _                                                                                                
  __ _  ___ _ __     ___ ___   __| | ___                                                                                           
 / _` |/ _ \ '_ \   / __/ _ \ / _` |/ _ \                                                                                          
| (_| |  __/ | | | | (_| (_) | (_| |  __/                                                                                          
 \__, |\___|_| |_|  \___\___/ \__,_|\___|                                                                                          
 |___/                                                                                                                             
;                                                                                                                                  
                                                                                                                                   
                                                                                                                                   
data _null_;                                                                                                                       
                                                                                                                                   
  set meta ;                                                                                                                       
                                                                                                                                   
  call symputx('table',table);                                                                                                     
  call symputx('dteBeg',dteBeg);                                                                                                   
  call symputx('dteEnd',dteEnd);                                                                                                   
                                                                                                                                   
  rc=dosubl('                                                                                                                      
        data _null_;                                                                                                               
          putlog "                                                                                                                 
        proc sql;                                " / "                                                                             
          create                                 " / "                                                                             
             table &table as                     " / "                                                                             
          select                                 " / "                                                                             
             l.name                              " / "                                                                             
            ,l.numbered                          " / "                                                                             
            ,r.area                              " / "                                                                             
          from                                   " / "                                                                             
             result as l, sample as r            " / "                                                                             
          where                                  " / "                                                                             
             l.numbered = r.numbered and         " / "                                                                             
             r.date between &dteBeg and &dteEnd  " / "                                                                             
        ;quit;";');                                                                                                                
run;quit;                                                                                                                          
                                                                                                                                   
                                                                                                                                   
                                                                                                                                   
proc sql;                                                                                                                          
  create                                                                                                                           
     table cust1 as                                                                                                                
  select                                                                                                                           
     l.name                                                                                                                        
    ,l.numbered                                                                                                                    
    ,r.area                                                                                                                        
  from                                                                                                                             
     result as l, sample as r                                                                                                      
  where                                                                                                                            
     l.numbered = r.numbered and                                                                                                   
     r.date between 21935 and 15399                                                                                                
;quit;                                                                                                                             
                                                                                                                                   
proc sql;                                                                                                                          
  create                                                                                                                           
     table cust2 as                                                                                                                
  select                                                                                                                           
     l.name                                                                                                                        
    ,l.numbered                                                                                                                    
    ,r.area                                                                                                                        
  from                                                                                                                             
     result as l, sample as r                                                                                                      
  where                                                                                                                            
     l.numbered = r.numbered and                                                                                                   
     r.date between 21963 and 15402                                                                                                
;quit;                                                                                                                             
                                                                                                                                   
proc sql;                                                                                                                          
  create                                                                                                                           
     table cust3 as                                                                                                                
  select                                                                                                                           
     l.name                                                                                                                        
    ,l.numbered                                                                                                                    
    ,r.area                                                                                                                        
  from                                                                                                                             
     result as l, sample as r                                                                                                      
  where                                                                                                                            
     l.numbered = r.numbered and                                                                                                   
     r.date between 21958 and 15393                                                                                                
;quit;                                                                                                                             
