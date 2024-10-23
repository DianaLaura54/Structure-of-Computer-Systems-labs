// lab22.cpp : Defines the entry point for the console application.
// https://www.ccsl.carleton.ca/~jamuir/rdtscpm1.pdf
#define rdtsc __asm __emit 0fh __asm __emit 031h
#define cpuid __asm __emit 0fh __asm __emit 0a2h

#include "stdafx.h"
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
using namespace std;

unsigned int n = 50000;
unsigned int* array1 = (unsigned int*)malloc(n * sizeof(unsigned int));
unsigned int v[50000];





void fill(unsigned int v[])
{
	srand(time(NULL));
	int randomNum = rand();
	int min = 1;
	int max = 100;
	
	for (int i = 0; i < n; i++)
	{
		int randomRange = (rand() % (max - min + 1)) + min;
		v[i] = randomRange;
		
	}

}
void bubblesortclassic(int n, unsigned int v[])
{
	for (int i = 0; i < n; i++)
	{
		for (int j = 1; j < n - 1; j++)
		{

			if (v[j - 1] > v[j])
			{
				int aux = v[j - 1];
				v[j - 1] = v[j];
				v[j] = aux;
				
			}
		}
		
	}
}

void bubblesort(int n, unsigned int v[])
{
	int ok = 0;
	for (int i = 0; i < n; i++)
	{
		ok = 0;
		for (int j = 1; j < n - i; j++)
		{

			if (v[j - 1] > v[j])
			{
				int aux = v[j - 1];
				v[j - 1] = v[j];
				v[j] = aux;
				ok = 1;
			}
		}
		if (ok == 0)
			break;
	}
}

int _tmain(int argc, _TCHAR* argv[])
{
	cout << "hello" << endl;
	unsigned cycles_high1 = 0, cycles_low1 = 0, cpuid_time = 0;
	unsigned cycles_high2 = 0, cycles_low2 = 0;
	unsigned __int64 temp_cycles1 = 0, temp_cycles2 = 0;
	__int64 total_cycles = 0;
	float var = 0;
	unsigned short a = 5, b = 2, c;
   //fill(v);
   //fill(array1);
	

	//compute the CPUID overhead
	__asm {
		pushad
		CPUID
		RDTSC
		mov cycles_high1, edx
		mov cycles_low1, eax
		popad
		pushad
		CPUID
		RDTSC
		popad
		pushad
		CPUID
		RDTSC
		mov cycles_high1, edx
		mov cycles_low1, eax
		popad
		pushad
		CPUID
		RDTSC
		popad
		pushad
		CPUID
		RDTSC
		mov cycles_high1, edx
		mov cycles_low1, eax
		popad
		pushad
		CPUID
		RDTSC
		sub eax, cycles_low1
		mov cpuid_time, eax
		popad
	}

	cycles_high1 = 0;
	cycles_low1 = 0;

	//Measure the code sequence
	__asm {
		pushad
		CPUID
		RDTSC
		mov cycles_high1, edx
		mov cycles_low1, eax
		popad
	}
	
   //bubblesort(n,v); // static optimized
	//bubblesortclassic(n,v); // static classic
	//bubblesort(n, array1); // dynamically optimized
  // bubblesortclassic(n,array1); //dynamically classic


	//Section of code to be measured
	__asm {
		pushad
		CPUID
	    //mov ax, a
	    //mov bx, b
	   //mul bx
	   //mov c, ax //10
	   // add eax, ebx // 301 302 290 246 252 264 281 250 306 298
	   //add var, eax //   252 248 268 266 304 295 250 283 267 289
	   //MUL edx // 422 483 352 320 440 444 410 290 285 366
	    //mov var,eax //  
	    //fdiv var // 820 707 715 744 788 806 922 930 864 901
		//fsub var // 800 806 754 698 694 680 779 736 794 815
		RDTSC
		mov cycles_high2, edx
		mov cycles_low2, eax
		popad
	}

	temp_cycles1 = ((unsigned __int64)cycles_high1 << 32) | cycles_low1;
	temp_cycles2 = ((unsigned __int64)cycles_high2 << 32) | cycles_low2;
  
  //total_cycles = temp_cycles2 - temp_cycles1;
	char any;
	//cout << "total cycles:"<<total_cycles <<" " << "cpuid_time: " << cpuid_time << " " << "exact execution time:" << total_cycles - cpuid_time;

	return 0;
}

