// C implementation

#include<stdio.h>
#include<stdlib.h>

int main() {
    int a, b, choice;

    printf("Enter the first 1-bit number (0 or 1): ");
    scanf("%d", &a);
    printf("Enter the second 1-bit number (0 or 1): ");
    scanf("%d", &b);

    printf("Select an operation:\n");
    printf("1. Addition 2. Subtraction 3. Multiplication 4. Division\n");
    printf("5. Logical AND 6. Logical OR 7. Logical NOT (A) 8. Logical NOT (B)\n");
    printf("9. Logical NAND 10. Logical NOR 11. Logical XOR 12. Logical XNOR\n");
    printf("13. Set Less Than (SLT) 14. Branch if Equal (BEQ)\n");
    printf("Enter your choice: ");
    scanf("%d", &choice);

    switch(choice) {
        case 1: printf("Addition: %d\n", (a + b) % 2); break;
        case 2: printf("Subtraction: %d\n", (a + !b + 1) % 2); break;
        case 3: printf("Multiplication: %d\n", a * b); break;
        case 4: 
            if(b==0) printf("Error: Division by zero\n");
            else printf("Division: %d\n", a / b); 
            break;
        case 5: printf("AND: %d\n", a & b); break;
        case 6: printf("OR: %d\n", a | b); break;
        case 7: printf("NOT (A): %d\n", !a); break;
        case 8: printf("NOT (B): %d\n", !b); break;
        case 9: printf("NAND: %d\n", !(a & b)); break;
        case 10: printf("NOR: %d\n", !(a | b)); break;
        case 11: printf("XOR: %d\n", a ^ b); break;
        case 12: printf("XNOR: %d\n", !(a ^ b)); break;
        case 13: printf("Set Less Than (SLT): %d\n", a < b); break;
        case 14: 
            if(a == b) goto label;
            else printf("not equal\n"); 
            break;
        default: printf("Invalid choice\n");
    }

    if(choice==14){ label: printf("equal\n"); exit(0); }    
    return 0;
}