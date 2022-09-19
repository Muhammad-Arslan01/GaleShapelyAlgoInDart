import 'dart:core';
//import 'dart:convert';
//import 'dart:ffi';
import 'package:gale_shapely_in_dart/gale_shapely_in_dart.dart' as gale_shapely_in_dart;





void main(List<String> arguments) {
  print('Hello world: ${gale_shapely_in_dart.calculate()}!');
        print("Gale Shapley Marriage Algorithm\n");
        /** list of men **/
        List<String> m = ["M1", "M2", "M3", "M4", "M5"];
        /** list of women **/
        List<String> w = ["W1", "W2", "W3", "W4", "W5"];
 
        /** men preference **/
         List<List<String>> mp = [["W5", "W2", "W3", "W4", "W1"], 
                         ["W2", "W5", "W1", "W3", "W4"], 
                         ["W4", "W3", "W2", "W1", "W5"], 
                         ["W1", "W2", "W3", "W4", "W5"],
                         ["W5", "W2", "W3", "W4", "W1"]];
        /** women preference **/                      
        List<List<String>> wp = [["M5", "M3", "M4", "M1", "M2"], 
                         ["M1", "M2", "M3", "M5", "M4"], 
                         ["M4", "M5", "M3", "M2", "M1"],
                         ["M5", "M2", "M1", "M4", "M3"], 
                         ["M2", "M1", "M4", "M3", "M5"]];
 
        GaleShapely gs = GaleShapely(m, w, mp, wp);   
}

class GaleShapely{
GaleShapely(List<String> m, List<String> w, List<List<String>> mp, List<List<String>> wp){
        N = mp.length;
        engagedCount = 0;
        men = m;
        women = w;
        menPref = mp;
        womenPref = wp;
        menEngaged = [];
        for(var i=0;i<m.length;i++){
        menEngaged.insert(i, -1);
    }
        //menEngaged = bool;
        womenPartner = [];
                for(var i=0;i<m.length;i++){
        menEngaged.insert(i, -1);
    }
        calcMatches();
    }
  int N=0;
  int engagedCount=0;
  late List<List<String>> menPref;
  late List<List<String>> womenPref;
  late List<String> men;
  late List<String> women;
  late List<String> womenPartner;
  late List<int> menEngaged;




/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
///

    void calcMatches(){
        while (engagedCount < N)
        {
            int free;
            for (free = 0; free < N; free++) {
              if (!(menEngaged[free]!=-1)) {
                  break;
                }
            }
 
            for (var i = 0; i < N && !(menEngaged[free]!=-1); i++)
            {
                var index = womenIndexOf(menPref[free][i]);
                if (womenPartner[index].compareTo("-1")==0)
                {
                    womenPartner[index] = men[free];
                    menEngaged[free] = 1;
                    engagedCount=(engagedCount+1);
                }
                else
                {
                    String currentPartner = womenPartner[index];
                    if (morePreference(currentPartner, men[free], index))
                    {
                        womenPartner[index] = men[free];
                        menEngaged[free] = 1;
                        menEngaged[menIndexOf(currentPartner)] = 1;
                    }
                }
            }            
        }
        printCouples();
    }


    bool morePreference(String curPartner, String newPartner, int index)
    {
        for (var i = 0; i < N; i++)
        {
            if (womenPref[index][i]==(newPartner)) {
              return true;
            }
            if (womenPref[index][i]==(curPartner)) {
              return false;
            }
        }
        return false;
    }
    //** get men index **/
    int menIndexOf(String str)
    {
        for (var i = 0; i < N; i++) {
          if (men[i]==(str)) {
              return i;
        }
            }
        return -1;
    }
    //** get women index **/
    int womenIndexOf(String str)
    {
        for (int i = 0; i < N; i++) {
          if (women[i]==(str)) {
              return i;
            }
        }
        return -1;
    }
    //** print couples **/
    void printCouples()
    {
        print("Couples are : ");
        for (int i = 0; i < N; i++)
        {
            print("${womenPartner[i]} ${women[i]}");
        }
    }



}

 
