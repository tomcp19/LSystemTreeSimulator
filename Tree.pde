class Tree {

String nom; 

Rule[] ruleset;
int nbRules;

char axiom1;
String equation1;
String LSysChar;
//si 2 règles
char axiom2;
String equation2;

float angle;

//couleur tige (rbga) +strokeWeight si utilisé
float tr,tb,tg,ta,sw;

ArrayList<PVector> BranchTip = new ArrayList();
//---- fleurs et fruits ----//
Fruit Fruit;
ArrayList<Fruit> Fruits; 
int FruitsNb;
float FruitsSize;
int r;
int b;
int g;
int o;
  
  
    Tree () 
  {

  }
  
  Tree(String _nom, int _nbRules, char _axiom1, String _equation1, String _LSysChar, float _angle, float _tr,float _tb,float _tg,float _ta, float _sw, int _FrNb, float _FrSz) 
  {
    this.nom = _nom;
    this.nbRules = _nbRules;
    this.axiom1 = _axiom1;
    this.equation1 = _equation1;
    this.LSysChar=_LSysChar;
    this.angle = _angle;
    this.axiom2 = '\0';
    this.equation2 = null;
    
    ruleset=new Rule[nbRules];
    ruleset[0] = new Rule(axiom1, equation1);
    
    //couleur tige (rbga) +strokeWeight si utilisé
    this.tr = _tr;
    this.tb = _tb;
    this.tg = _tg;
    this.ta = _ta;
    this.sw = _sw;
    this.FruitsNb = _FrNb;
    this.FruitsSize = _FrSz;
    
    Fruits = new ArrayList();
  }
  
    Tree(String _nom, int _nbRules, char _axiom1, String _equation1, String _LSysChar, float _angle, char _axiom2, String _equation2, float _tr,float _tb,float _tg,float _ta, float _sw,int _FrNb, float _FrSz) 
  {
    this.nom = _nom;
    this.nbRules = _nbRules;
    this.axiom1 = _axiom1;
    this.equation1 = _equation1;
    this.LSysChar=_LSysChar;
    this.axiom2 = _axiom2;
    this.equation2 = _equation2;
    
    this.angle = _angle;
    ruleset=new Rule[nbRules];
    ruleset[0] = new Rule(axiom1, equation1);
    ruleset[1] = new Rule(axiom2, equation2);
    
    //couleur tige (rbga) +strokeWeight si utilisé
    this.tr = _tr;
    this.tb = _tb;
    this.tg = _tg;
    this.ta = _ta;
    this.sw = _sw;
    this.FruitsNb = _FrNb;
    this.FruitsSize = _FrSz;
    
    Fruits = new ArrayList();
  }
  
  public void setFruits(int nb, float size, int _r, int _b, int _g, int _o)
  {
    
    if(BranchTip != null)
    {
      for (int i = BranchTip.size()-1; i > BranchTip.size()-(size+1); i--) 
      {
        PVector VFruit = BranchTip.get(i);
        size = randomGaussian() * size;//distribution normale autour de la taille fixée
        Fruit = new Fruit(VFruit, size);
        Fruit.setColors(_r, _b, _g, _o);
        Fruits.add(Fruit);
      }
    }
  }
  
  
  public void setFruits(int nb, float size)
    {
    if(BranchTip != null)
    {   
      //tirage au hasard, parmi les bouts de branches, de l'amplacement du nombre nb de fruits, sans duplicat d'emplacement
      int[] Tips = new int[nb];
      for(int i = 0; i < nb; i++)
      {
        
         float max = float(BranchTip.size());
         boolean drawn;
         float r;
       
         do
         { //verification si unique
            r = random(0, max); 
            drawn  = false;
           
              for(int j = 0; j < Tips.length-1; j ++)
              {
                  if(Tips[i] == int(r))
                  { 
                    drawn = true;
                  }    
              }
          }while (drawn);
          
         Tips[i] = int(r);  
      }
      
      for(int i = 0; i < nb; i++) 
      {
        PVector VFruit = BranchTip.get(Tips[i]);
        
        size = randomGaussian()*2 + size;//distribution normale autour de la taille fixée
        
        Fruit = new Fruit(VFruit, size);
        Fruit.setColors(255, 0, 0, 150);
        Fruits.add(Fruit);
      }
    }
  }
  
  public void setBranchTip(ArrayList TipsfromTurtle)
  {
    BranchTip = TipsfromTurtle;
  }
  
  public ArrayList getFruits()
  {
    return Fruits;
  }
  
  public String getLSysChar()
  {
     return  LSysChar;
  }
  
    public char getAxiom1()
  {
     return  axiom1;
  }
  
  public char getAxiom2()
  {
    return axiom2;
  }
  
  public String getNom()
  {
    return nom;
  }
  
    public String getEquation1()
  {
     return  equation1;
  }
  
  public String getEquation2()
  {
    return  equation2;
  }
  
  public Rule[] getRuleset()
  {
     return  ruleset;
  }
  
  public Float getAngle()
  {
     return  angle;
  }
  
  public float getTreeColorsR()
  {
    return tr;
  }
    public float getTreeColorsB()
  {
    return tb;
  }
    public float getTreeColorsG()
  {
    return tg;
  }
    public float getTreeColorsA()
  {
    return ta;
  }
    public float getTreeColorsSW()
  {
    return sw;
  }
}
