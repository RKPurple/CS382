#include "buggy.h"

void init(int *arr, int size, int *counter)
{
	for (int i = 0; i < size; i++)
	{
		arr[i] = 0;
	}
	(*counter) = 0;
}

void add(int *arr, int i, int count)
{
	arr[count] = i; // Change arr[++count] to arr[count]
}

void print_array(int *arr, int count)
{
	for (int i = 0; i < count; i++)
		printf("%d ", arr[i]);
	printf("\n");
}

int contains(int *arr, int count, int target)
{

	int i;
	for (i = 0; i < count; ++i) // Removed floating semicolon
	{
		if (arr[i] == target)
			return 1;
	} // Remove else statement in the for loop
	return 0;
}
