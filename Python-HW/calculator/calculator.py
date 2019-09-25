#design calculator
import sys
from PyQt5 import QtWidgets, uic, QtGui
import math
qtCreatorFile = "./mainwindow.ui" # Enter file here.

Ui_MainWindow, QtBaseClass = uic.loadUiType(qtCreatorFile)

class MyApp(QtWidgets.QMainWindow, Ui_MainWindow):
   
    out=0
    str1=''
    str2=''
    operaold=''
    def __init__(self):
        QtWidgets.QMainWindow.__init__(self)
        Ui_MainWindow.__init__(self)
        self.setupUi(self)
        self.Calculate('c')
        ##add your function
        self.btn0.clicked.connect(lambda: self.Calculate(0))
        self.btn1.clicked.connect(lambda: self.Calculate(1))
        self.btn2.clicked.connect(lambda: self.Calculate(2))
        self.btn3.clicked.connect(lambda: self.Calculate(3))
        self.btn4.clicked.connect(lambda: self.Calculate(4))
        self.btn5.clicked.connect(lambda: self.Calculate(5))
        self.btn6.clicked.connect(lambda: self.Calculate(6))
        self.btn7.clicked.connect(lambda: self.Calculate(7))
        self.btn8.clicked.connect(lambda: self.Calculate(8))
        self.btn9.clicked.connect(lambda: self.Calculate(9))
        self.btnplusmins.clicked.connect(lambda: self.Calculate('minusplus'))
        self.btndot.clicked.connect(lambda: self.Calculate('.'))
        self.btnplus.clicked.connect(lambda: self.Calculate('+'))
        self.btnmins.clicked.connect(lambda: self.Calculate('-'))
        self.btnmul.clicked.connect(lambda: self.Calculate('*'))
        self.btndevide.clicked.connect(lambda: self.Calculate('/'))
        self.btnlog.clicked.connect(lambda: self.Calculate('log'))
        self.btnsqrt.clicked.connect(lambda: self.Calculate('sqrt'))
        self.btnclear.clicked.connect(lambda: self.Calculate('c'))
        self.btnequal.clicked.connect(lambda: self.Calculate('equal'))
    ## add those function
    def Calculate(self,opera):
        print("str1",self.str1,"str2",self.str2,"out",self.out)
        if(opera == 'c'):#clear
         
            self.out=0
            self.str1=''
            self.str2=''
            self.operaold=''
            self.output.setText('0')
        elif(isinstance(opera,int)):#store the value
             
            self.str1=self.str1 + str(opera)
            print(self.str1)
            self.output.setText(self.str1)
        elif(opera =='.'):
            if(self.str1.find('.')!=-1):
                pass
            else:
                self.str1=self.str1 + str(opera)
            print(self.str1)
            self.output.setText(self.str1)
        elif(opera in [ '+', '-', '*','/']):
            
##            print(self.str1+operaold+self.str2)
##            if(self.str2==''):
##                if(operaold in [ '+', '-']):
##                    self.str2 = '0'
##                if(operaold in [ '*', '/']):
##                    self.str2 = '1'
##            print(self.str1+operaold+self.str2)
            if(self.operaold==''):                      
                self.out=self.str1
                self.str2=self.str1
                
            elif(self.str1 !=''):                
                self.out=eval(self.str2+self.operaold+self.str1)
               
                self.str2=str(str(self.out))
                
            self.operaold =opera
         
            
##            print(self.str1+opera+self.str2)
            print("out",self.out)
            self.output.setText(self.out)
            self.output.append(opera)
            self.str1=''
        elif(opera == 'log'):
            try:
                if(self.str1==''):
                    self.str2= str(math.log(float(self.str2)))
                    print(self.str2)
                    self.output.setText(self.str2)
                elif(self.str2==''):
                    self.str1= str(math.log(float(self.str1)))
                    print(self.str1)
                    self.output.setText(self.str1)
                else:
                    self.out=eval(self.str2+self.operaold+self.str1)
                    self.str2=str(self.out)
                    self.str2= str(math.log(float(self.str2)))
                    print(self.str2)
                    self.output.setText(self.str2)
            except:
                pass
        elif(opera == 'sqrt'):
            try:
                if(self.str1==''):
                    self.str2= str(math.sqrt(float(self.str2)))
                    print(self.str2)
                    self.output.setText(self.str2)
                elif(self.str2==''):
                    self.str1= str(math.sqrt(float(self.str1)))
                    print(self.str1)
                    self.output.setText(self.str1)
                else:
                    self.out=eval(self.str2+self.operaold+self.str1)
                    self.str2=str(self.out)
                    self.str2= str(math.sqrt(float(self.str2)))
                    print(self.str2)
                    self.output.setText(self.str2)
            except:
                pass
        elif(opera == 'minusplus'):
            try:
                if(self.str1==''):
                    self.str2= str(-(float(self.str2)))
                    print(self.str2)
                    self.output.setText(self.str2)
                elif(self.str2==''):
                    self.str1= str(-(float(self.str1)))
                    print(self.str1)
                    self.output.setText(self.str1)
                else:
                    self.out=eval(self.str2+self.operaold+self.str1)
                    self.str2=str(self.out)
                    self.str1=''
                    self.str2= str(-(float(self.str2)))
                    print(self.str2)
                    self.output.setText(self.str2)
            except:
                pass
        elif(opera =='equal'):
            try:
                if(self.str1==''):
                    print(self.str2)
                    self.output.setText(self.str2)
                elif(self.str2==''):
                    print("a",self.str1)
                    self.output.setText(self.str1)
                    self.str2=self.str1
                    self.str1=''
                    self.operaold=''
                else:
                    if(self.operaold==''):
                        pass
                        
                    else:
                        self.out=eval(self.str2+self.operaold+self.str1)
                        print(self.out)
                        self.output.setText(str(self.out))
                    self.str1=''
                    self.str2=str(self.out)
                self.operaold =''
            except:
                pass
            
        
            
##            
            
            
            
        print("str1",self.str1,"str2",self.str2,"out",self.out,"opold",self.operaold)
        print("=============================")
        pass

    
            
    def closeEvent(self, event):
        #重新定义colseEvent
        try:        
            reply = QtWidgets.QMessageBox.question(self, 'Message',"Are you ready to quit？",QtWidgets.QMessageBox.Yes, QtWidgets.QMessageBox.No)
        except:
            pass         
        else:           
            if reply == QtWidgets.QMessageBox.Yes:
                event.accept()
            else:
                event.ignore()
            
if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    window = MyApp()
    window.show()
    sys.exit(app.exec_())
