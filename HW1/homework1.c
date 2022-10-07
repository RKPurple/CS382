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

void sort_nib(int *arr, int length)
{
    char *bytes = (char *)arr; // Convert to Char array

    for (int i = 0; i < (length * 4); i++) // Loop through the individual bytes of the array
    {
        char first_nib = (*(bytes + i) >> 4) & 0x0F; // store first 4 binary digits
        char second_nib = (*(bytes + i)) & 0x0F;     // store second 4 binary digits
    LOOP:
        if (first_nib > second_nib) // If the first four binary digits are greater than the second 4 swap them
        {
            *(bytes + i) = (second_nib << 4) | (first_nib); // swap the bytes by oring the two chars
            first_nib = (*(bytes + i) >> 4) & 0x0F;         // update first and second
            second_nib = (*(bytes + i)) & 0x0F;
        }
        for (int j = i + 1; j < (length * 4); j++) // loop until you find an element greater than first_nib than swap accordingly
        {
            char next_second_nib = (*(bytes + j)) & 0x0F; // check the next bytes binary digits
            char next_first_nib = (*(bytes + j) >> 4) & 0x0F;
            if (next_second_nib > first_nib) // swap the places of the first nib of original byte with the second nib of the one your crosschecking
            {
                *(bytes + j) = (next_first_nib << 4) | (first_nib); // update both bytes
                *(bytes + i) = (next_second_nib << 4) | (second_nib);
                first_nib = (*(bytes + i) >> 4) & 0x0F; // update first and second nib
                second_nib = (*(bytes + i)) & 0x0F;
                goto LOOP; // return to top loop
            }
            if (next_first_nib > first_nib) // swap the places of the first nib of original byte with the second nib of the one your crosschecking
            {
                *(bytes + j) = (first_nib << 4) | (next_second_nib); // update both bytes
                *(bytes + i) = (next_first_nib << 4) | (second_nib);
                first_nib = (*(bytes + i) >> 4) & 0x0F; // update first and second nib
                second_nib = (*(bytes + i)) & 0x0F;
                goto LOOP; // return to top loop
            }
        }
    }
    int end = length - 1; // reverse the array cuz im kewl like that 😎
    for (int i = 0; i < length / 2; i++)
    {
        int store = *(arr + i);
        *(arr + i) = *(arr + end);
        *(arr + end) = store;
        end--;
    }
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
    sort_nib(arr, 3);
    for (int i = 0; i < 3; i++)
    {
        printf("0x%08x ", arr[i]);
    }
    puts(" ");

    return 0;
}