#include <stdio.h>

#define N 6
#define M 6

int findMinElement(int matrix[N][M])
{
    int min = matrix[0][0];

    for (int i = 1; i < N && i < M; i++) {
        if (matrix[i][i] < min) {
            min = matrix[i][i];
        }
    }

    return min;
}

int main()
{
    int matrix[N][M] = {
        { 12, 7, 31, 4, 5, 6 },
        { 8, 10, 2, 11, 1, 9 },
        { 14, 15, 6, 13, 12, 7 },
        { 16, 17, 18, 5, 19, 20 },
        { 21, 22, 23, 24, 3, 25 },
        { 26, 27, 28, 29, 30, 4 }
    };

    int min = findMinElement(matrix);

    printf("min element: %d\n", min);

    return 0;
}
