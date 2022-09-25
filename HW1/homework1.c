#include <stdio.h>

// Rohan Kallur
// I pledge my honor that I have abided by the Stevens Honor System.

void strcpy(char *src, char *dst)
{
    int i = 0;              // Iterator variable
LOOP:                       // Label for go to statement
    if (*(src + i) == '\0') // Check to see if you reached the terminator
    {
        *(dst + i) = '\0'; // copy terminator
        return;            // end the function
    }
    else
    {
        *(dst + i) = *(src + i); // Copy the character value of src iterating through into dst's corresponding area
        i++;                     // increment the counter
        goto LOOP;               // return to top of the if statements
    }
}

int dot_prod(char *vec_a, char *vec_b, int length, int size_elem)
{
    // Don't cast vectors directly, such as int* va = (int*)vec_a;
    int i = 0;       // incrementing elements
    int tot = 0;     // store how much the total amount is as we iterate through it
LOOP:                // go to label
    if (i == length) // check to see if you covered every element
    {
        return tot;
    }
    else
    {
        int a = *(vec_a + (size_elem * i)); // store value of element by casting the element to an int variable
        int b = *(vec_b + (size_elem * i)); // same as above but for the other array
        i++;                                // increment
        tot += (a * b);                     // add to the total
        goto LOOP;                          // run it back
    }
    return tot;
}

void sort_nib(int *arr)
{
    char *bytes = (char *)arr;
}

int main()
{
    char str1[] = "382 is the best!";
    char str2[100] = {0};

    strcpy(str1, str2);
    puts(str1);
    puts(str2);

    int vec_a[3] = {12, 34, 10};
    int vec_b[3] = {10, 20, 30};
    int dot = dot_prod((char *)vec_a, (char *)vec_b, 3, sizeof(int));
    printf("%d\n", dot);

    int arr[3] = {0x12BFDA09, 0x9089CDBA, 0x56788910};
    sort_nib(arr);
    for (int i = 0; i < 3; i++)
    {
        printf("0x%x ", arr[i]);
    }
    puts(" ");

    return 0;
}