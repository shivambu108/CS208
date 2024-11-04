// Shivambu Dev Pandey
// 23bcs123

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAX 3

void initialize(int a1[MAX][MAX], int a2[MAX][MAX]);
void add(int a1[MAX][MAX], int a2[MAX][MAX], int res[MAX][MAX]);
void printMatrix(int matrix[MAX][MAX]);

int main() {
    int a1[MAX][MAX], a2[MAX][MAX], res[MAX][MAX];
    srand(time(0));

    initialize(a1, a2);
    add(a1, a2, res);

    printf("Matrix 1:\n"); printMatrix(a1);
    printf("Matrix 2:\n"); printMatrix(a2);
    printf("Resultant Matrix (Sum):\n"); printMatrix(res);

    return 0;
}

void initialize(int a1[MAX][MAX], int a2[MAX][MAX]) {
    for (int i = 0; i < MAX; i++) {
        for (int j = 0; j < MAX; j++) {
            a1[i][j] = rand() % 10;
            a2[i][j] = rand() % 10;
        }
    }
}

void add(int a1[MAX][MAX], int a2[MAX][MAX], int res[MAX][MAX]) {
    for (int i = 0; i < MAX; i++) {
        for (int j = 0; j < MAX; j++) {
            res[i][j] = a1[i][j] + a2[i][j];
        }
    }
}

void printMatrix(int matrix[MAX][MAX]) {
    for (int i = 0; i < MAX; i++) {
        for (int j = 0; j < MAX; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}
    
