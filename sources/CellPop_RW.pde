//Some fonctions to read or write in the score file
ArrayList<String[]> read(String path)
{
   ArrayList<String[]> data = new ArrayList();
   String[] file;
   int compteur = 0;
   
   file = loadStrings(path);
   
   //If the file doesn't exists
   if(file == null)
   {
      createEmptyScoreFile(path);
      file = loadStrings(path);
   }
   
   while(compteur < file.length)
   {
     String i[] = split(file[compteur], " ");
     data.add(i);
     compteur++;
   }
   return data;
}
void updateFile(String level, int score, float time)
{
  ArrayList<String[]> data = read("score.txt");
  for(int i = 0; i < data.size(); i++)
  {
    if(data.get(i)[0].equals(level))
    {
      if(int(data.get(i)[1]) < score)
      { //Override the score
        data.get(i)[1] = String.valueOf(score);
        data.get(i)[2] = String.valueOf(time);
      }
      write(data,"score.txt");
      return; //Stop update the score
    }
  }
  //If the score of this level is not write yet :
  String[] newLine = new String[] {level, String.valueOf(score), String.valueOf(time)};
  data.add(newLine);
}
void write(ArrayList<String[]> data, String path)
{
   PrintWriter output;
   output = createWriter(path);
   for(int i = 0; i < data.size(); i++)
   {
     output.println(data.get(i)[0] + " " + data.get(i)[1] + " " + data.get(i)[2]);
   }
   output.close();
}
void createEmptyScoreFile(String path)
{
    PrintWriter output;
    output = createWriter(path);
    output.println("easy 0 0");
    output.println("medium 0 0");
    output.println("hard 0 0");
    output.println("insane 0 0");
    output.close();
}