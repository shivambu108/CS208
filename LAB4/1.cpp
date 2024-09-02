// program 1 : Implement the 1-bit ALU capable of performing the various logical, arithmetic and SLT operations 
// as discussed in the class  (mips). Implement in C and C++ programming languages.

//CPP implementation

#include<bits/stdc++.h>
using namespace std;

int main() {
    int a, b, choice;

    cout<<"Enter the first 1-bit number (0 or 1): "; cin>>a;
    cout<<"Enter the second 1-bit number (0 or 1): "; cin>>b;

    cout<<"Select an operation:"<<endl;
    cout<<"1. Addition 2. Subtraction 3. Multiplication 4. Division"<<endl;
    cout<<"5. Logical AND 6. Logical OR 7. Logical NOT (A) 8. Logical NOT (B)"<<endl;
    cout<<"9. Logical NAND 10. Logical NOR 11. Logical XOR 12. Logical XNOR"<<endl;
    cout<<"13. Set Less Than (SLT) 14. Branch if Equal (BEQ)"<<endl;
    cout<<"Enter your choice: "; cin>>choice;

    switch(choice) {
        case 1: cout<<"Addition: "<< (a + b) % 2 <<endl; break;
        case 2: cout<<"Subtraction: "<< (a + !b + 1) % 2 <<endl; break;
        case 3: cout<<"Multiplication: "<< a * b <<endl; break;
        case 4: 
            if(b==0) cout<<"Error: Division by zero "<<endl;
            else cout<<"Division: "<< a / b <<endl; 
            break;
        case 5: cout<<"AND: "<< (a & b) <<endl; break;
        case 6: cout<<"OR: "<< (a | b) <<endl; break;
        case 7: cout<<"NOT (A): "<< !a <<endl; break;
        case 8: cout<<"NOT (B): "<< !b <<endl; break;
        case 9: cout<<"NAND: "<< !(a & b )<<endl; break;
        case 10: cout<<"NOR: "<< !(a | b) <<endl; break;
        case 11: cout<<"XOR: "<< (a ^ b) <<endl; break;
        case 12: cout<<"XNOR: "<< !(a ^ b) <<endl; break;
        case 13: cout<<"Set Less Than (SLT): "<< (a < b) <<endl; break;
        case 14: 
            if(a == b) goto label ;
            else cout<<"not equal"<<endl; 
            break;
        default: cout<<"Invalid choice"<<endl;
    }

    if(choice==14){
        label: cout<<"equal"<<endl; exit(0);
    }    
    return 0;
}