class ScreenMachine
{
   Screen currentScreen;
   public void changeScreen(Screen screen)
   {
      if(currentScreen != null)
        {}//currentScreen.close();
        
      currentScreen = screen;
   }
   public void update()
   {
       if(currentScreen != null)
         currentScreen.update(this);
   }
   public void display()
   {
       if(currentScreen != null)
         currentScreen.display();
   }
   public Screen getCurrentScreen()
   {
      return currentScreen; 
   }
}
