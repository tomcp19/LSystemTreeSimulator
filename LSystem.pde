// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// An LSystem has a starting sentence
// An a ruleset
// Each generation recursively replaces characteres in the sentence
// Based on the rulset

class LSystem {

  String sentence;     // The sentence (a String)
  Rule[] ruleset;      // The ruleset (an array of Rule objects)
  int generation;      // Keeping track of the generation #

  // Construct an LSystem with a startin sentence and a ruleset
  LSystem(String axiom, Rule[] r) {
    sentence = axiom;
    ruleset = r;
    generation = 0;
  }

  // Generate the next generation
  void generate() {

    StringBuffer nextgen = new StringBuffer();

    for (int i = 0; i < sentence.length(); i++) {

      char curr = sentence.charAt(i);

      String replace = "" + curr;

      for (int j = 0; j < ruleset.length; j++) {
        char a = ruleset[j].getA();

        if (a == curr) {
          replace = ruleset[j].getB();
          break; 
        }
      }
      // Append replacement String
      nextgen.append(replace);
    }
    // Replace sentence
    sentence = nextgen.toString();
    // Increment generation
    generation++;
  }

  String getSentence() {
    return sentence; 
  }

  int getGeneration() {
    return generation; 
  }
 /* 
 public void setLSystem(String axiom, Rule[] r)
 {
     sentence = axiom;
    ruleset = r;
    generation = 0;
 }*/


}
