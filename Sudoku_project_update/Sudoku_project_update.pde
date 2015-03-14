String [][] numbers = new String[9][9];
int xCoOrd = 0;//updated when mouseclicked
int yCoOrd = 0;//updated when mouseclicked
int tabNum = 0;//
int lineNum = 0;

void setup() {
  size( 960, 720);
  background(255);
  for ( int j = 0; j < 9; j++) {
    for ( int i = 0; i < 9; i++) {
      numbers[j][i] = "";
    }
  }
}

void draw() {
  Grid();
  Input();
  SolveButton();
  CurrentSquare();
}

void Grid() {
  //Draws heavy and lighter lines to make the grid
  background(255);
  stroke (0);
  fill (255);
  for ( int j = 0; j <= 9; j++) {
    if (j % 3 == 0) {
      strokeWeight(3);
    } else {
      strokeWeight(1);
    }
    line( j*width/9, 0, j*width/9, 9*height/11);
  }
  for ( int i = 0; i <= 9; i++) {
    if (i % 3 == 0) {
      strokeWeight(3);
    } else {
      strokeWeight(1);
    }
    line( 0, i*height/11, width, i*height/11);
  }
}

void Input () {
  
  for ( int j = 0; j < 9; j++) {
    for ( int i = 0; i < 9; i++) {
      fill(0);
      textSize(32);
      textAlign(CENTER, CENTER);
      text(numbers[j][i], ((2*i)+1)*width/18, ((2*j)+1)*height/22);
    }
  }
  int i = xCoOrd/( width/9);
  int j = yCoOrd/( height/11);
}


void SolveButton() {
  // Draws solve button calls SudokuSolver if clicked
  fill(255, 0, 0);
  rect( 140, 645, 150, 55);
  fill(0);
  text("Solve it", 205, 665);
  if ( xCoOrd > 140 && xCoOrd < 290 && yCoOrd > 645 && yCoOrd < 700) {
    SudokuSolver();
  }
}

void mousePressed() {
  // updates xCoOrd and yCoOrd and resets tabNum and lineNum values
  xCoOrd = mouseX;
  yCoOrd = mouseY;
  
  tabNum = 0;
  lineNum = 0;
}

void keyPressed() {
  //Let's you change square and will input number if valid
  int n = 0;
  int i = xCoOrd/( width/9);
  int j = yCoOrd/( height/11);
  if ( key == CODED ) {
    if ( ((i+tabNum)%9) < 8) {
      if ( keyCode == RIGHT ) {
        tabNum++;
      }
    }
    if ( ((i+tabNum)%9) > 0 ) {
      if ( keyCode == LEFT ) {
        tabNum--;
      }
    }
    if ( (j+((i+tabNum)/9)+lineNum) > 0 ) {
      if ( keyCode == UP ) {
        lineNum--;
      }
    }
    if ( (j+((i+tabNum)/9)+lineNum) < 8 ) {
      if ( keyCode == DOWN ) {
        tabNum = tabNum + 9;
      }
    }
  }
  if ( (i+tabNum)%9 < 0) {
    tabNum = 9 - tabNum; 
    lineNum--;
  }
  if ( key == TAB ) {
    tabNum++;
  }
  if ( key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9' ) {
    if (ErrorInputCheck(str(key)) == false) {
      numbers[j+((i+tabNum)/9)+lineNum][(i+tabNum)%9] = str(key);
    } else if (ErrorInputCheck(str(key)) == true) {
      stroke(255, 0, 0);
      strokeWeight(3);
      line(((i+tabNum)%9)*(width/9), (j+((i+tabNum)/9)+lineNum)*(height/11), (((i+tabNum)%9)*(width/9))+width/9, (j+((i+tabNum)/9)+lineNum)*(height/11)); 
      line(((i+tabNum)%9)*(width/9), (j+((i+tabNum)/9)+lineNum)*(height/11), ((i+tabNum)%9)*(width/9), ((j+((i+tabNum)/9)+lineNum)*(height/11))+(height/11)); 
      line((((i+tabNum)%9)*(width/9))+width/9, (j+((i+tabNum)/9)+lineNum)*(height/11), (((i+tabNum)%9)*(width/9))+width/9, ((j+((i+tabNum)/9)+lineNum)*(height/11))+(height/11)); 
      line(((i+tabNum)%9)*(width/9), ((j+((i+tabNum)/9)+lineNum)*(height/11))+(height/11), (((i+tabNum)%9)*(width/9))+width/9, ((j+((i+tabNum)/9)+lineNum)*(height/11))+(height/11));
    }
  }
  if ( key == BACKSPACE ) {
    numbers[j+((i+tabNum)/9)+lineNum][(i+tabNum)%9] = "";
  }
}

boolean ErrorInputCheck( String number) {
  //Checks to see if your input is a valid move
  int i = xCoOrd/( width/9);
  int j = yCoOrd/( height/11);
  for ( int x = 0; x < 9; x++) {
    if ( number.equals(numbers[j+((i+tabNum)/9)+lineNum][x])) {
      return true;
    }
  }
  for ( int y = 0; y < 9; y++) {
    if ( number.equals(numbers[y][(i+tabNum)%9])) {
      return true;
    }
  }
  for ( int x = 0; x < 3; x++) {
    for ( int y = 0; y < 3; y++) {
      if ( number.equals(numbers[y+(3*(((j+(i+tabNum)/9)+lineNum)/3))][x+(3*(((i+tabNum)%9)/3))])) {
        return true;
      }
    }
  }
  return false;
}

void CurrentSquare() {
  //Draws line at the currently selected cell
  int i = xCoOrd/( width/9);
  int j = yCoOrd/( height/11);
  for (int x = 0; x < 20; x++) {
    if (x < 8 &&  j+((i+tabNum)/9)+lineNum < 9 && (i+tabNum)%9 < 9) { //Needed in case you click outside the grid
      if (numbers[j+((i+tabNum)/9)+lineNum][(i+tabNum)%9].equals("") || numbers[j+((i+tabNum)/9)+lineNum][(i+tabNum)%9].equals("0")) {
        line((((i+tabNum)%9)*(width/9))+(width/18), ((j+((i+tabNum)/9)+lineNum)*(height/11))+(height/110), (((i+tabNum)%9)*(width/9))+(width/18), ((j+((i+tabNum)/9)+lineNum)*(height/11))+(height/11)-(height/110));
      } else {
        line((((i+tabNum)%9)*(width/9))+(width/36), ((j+((i+tabNum)/9)+lineNum)*(height/11))+(height/110), (((i+tabNum)%9)*(width/9))+(width/36), ((j+((i+tabNum)/9)+lineNum)*(height/11))+(height/11)-(height/110));
      }
    }
    if (x==20) {
      x=0;
    }
  }
}



void SudokuSolver() {
  int[] grid = new int[81];

  for ( int j = 0; j < 9; j++) {
    for ( int i = 0; i < 9; i++) {
      grid[i + (j*9)] = int(numbers[j][i]) ;
    }
  }


  int[] tempGrid = new int[28];
  int gridCounter=0;
  int line =0;

  int n=0; 
  int column=0; 
  int box=0;
  int one=0;
  int two=0;
  int three=0;
  int four=0;
  int five=0;
  int six=0;
  int seven=0;
  int eight=0;
  int nine=0;
  for (int c=0; c<=4; c++)
  {
    for (n = 0; n <=80; n++ )
    {
      if (grid[n] ==0)
      {
        if (line<=2 && column<=2) {
          box=0;
        } else if (line<=2 && column<=5) {
          box=3;
        } else if (line<=2) {
          box=6;
        } else if (line<=5 && column<=2) {
          box=27;
        } else if (line<=5 && column<=5) {
          box=30;
        } else if (line<=5) {
          box=33;
        } else if (line<=8 && column<=2) {
          box=54;
        } else if (line<=8 && column<=5) {
          box=57;
        } else if (line<=8) {
          box=60;
        } else {
        }
        for (int x=0; x<=8; x++)
        {
          tempGrid[x]   =  grid[x + (line * 9)];
          tempGrid[x+9]  =  grid[column + (x * 9)];
          if (x<=2)
          {
            tempGrid[x+18]  =  grid[box + x];
            tempGrid[x+21]  =  grid[box + 9 + x];
            tempGrid[x+24]  =  grid[box + 18 + x];
          } else {
          }
        }//end of loop
        for (int y=0; y<=27; y++)
        {
          if (tempGrid[y] == 1) {
            one =1;
          } else if (tempGrid[y] == 2) {
            two = 10;
          } else if (tempGrid[y] == 3) {
            three=100;
          } else if (tempGrid[y] == 4) {
            four =1000;
          } else if (tempGrid[y] == 5) {
            five =10000;
          } else if (tempGrid[y] == 6) {
            six = 100000;
          } else if (tempGrid[y] == 7) {
            seven=1000000;
          } else if (tempGrid[y] == 8) {
            eight=10000000;
          } else if (tempGrid[y] == 9) {
            nine= 100000000;
          } else {
          }
        }//end of for loop
        int tempTotal = one + two + three + four + five + six + seven + eight + nine;
        one=0;
        two=0;
        three=0;
        four=0;
        five=0;
        six=0;
        seven=0;
        eight=0;
        nine=0;
        if     (tempTotal==111111110) {
          grid[n]=1;
        } else if (tempTotal==111111101) {
          grid[n]=2;
        } else if (tempTotal==111111011) {
          grid[n]=3;
        } else if (tempTotal==111110111) {
          grid[n]=4;
        } else if (tempTotal==111101111) {
          grid[n]=5;
        } else if (tempTotal==111011111) {
          grid[n]=6;
        } else if (tempTotal==110111111) {
          grid[n]=7;
        } else if (tempTotal==101111111) {
          grid[n]=8;
        } else if (tempTotal==11111111) {
          grid[n]=9;
        } else {
        }
      } else {
      }
      column++;
      if (column==9) {
        column=0;
        line++;
      } else {
      }
    }
    //end of for loop
    line =0;
    column=0;
  }
  for ( int j = 0; j < 9; j++) {
    for ( int i = 0; i < 9; i++) {
      numbers[j][i] = str(grid[i + (j*9)]) ;
    }
  }
  //  for (int count2=0; count2<=8; count2++)
  //  {
  //    for (int count1=1; count1<=9; count1++)
  //    {
  //      System.out.print("  " +grid[(count1+(count2*9))-1]);
  //    }
  //    System.out.print("\n");
  //  }
}// end of main
//}// end of class

