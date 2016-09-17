float adjustTextSize(float size) {
  //Template : 
  // widthInit : 500 -> textSize : size -> widthFinal : width
  // finalSize = (widthFinal * size)/widthInit
  return (width*size)/500;
}