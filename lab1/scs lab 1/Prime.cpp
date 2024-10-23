
#include "stdlib.h"
#include "time.h"
#include <windows.h>
#include <stdio.h>


unsigned long* numbers;
typedef struct MyData {
    unsigned long start;
    unsigned long len;
} MYDATA, *PMYDATA;
DWORD WINAPI MyThreadFunction( LPVOID lpParam );

int is_prime(unsigned long n)
{

	for (unsigned long i=2; i<n; i++)
	{
		if(n%i == 0) return 0;
	}
	return 1;
}

int main(int argc, char* argv[])
{
    clock_t start_time,end_time;
	unsigned long lEnd, failure, mult, len, nThreads;
	unsigned long i;
	HANDLE*  hThreadArray;
	DWORD*   dwThreadIdArray;
	PMYDATA* pDataArray;

    if (argc != 3) {

		lEnd = 100000;
		nThreads = 32;
    }
	else {


		lEnd = atol(argv[1]);
		nThreads = atol(argv[2]);
	}
	//the first clock
	start_time = clock();
		hThreadArray = new HANDLE[nThreads];
		dwThreadIdArray = new DWORD[nThreads];
		pDataArray = new PMYDATA[nThreads];




		len = lEnd-1;

		numbers = new unsigned long[len];

		for (i=0; i<len; i++)
		{
			numbers[i] = i+2;
		}

		for(i=0;i<nThreads;i++)
		{

			pDataArray[i] = (PMYDATA) HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY,sizeof(MYDATA));
			pDataArray[i]->len = len/nThreads;
			pDataArray[i]->start = i*len/nThreads;
			if(i==nThreads-1)
			{
				pDataArray[i]->len += len-(len/nThreads+i*len/nThreads);
			}
			hThreadArray[i] = CreateThread(NULL, 0,MyThreadFunction,pDataArray[i],0,&dwThreadIdArray[i]);
		}


		WaitForMultipleObjects(nThreads, hThreadArray, TRUE, INFINITE);
		//measure the end of execution
		end_time = clock();
        printf("Final time %ld\n", end_time-start_time);
		for(int i=0; i<nThreads; i++)
		{
			CloseHandle(hThreadArray[i]);
			if(pDataArray[i] != NULL)
			{
				HeapFree(GetProcessHeap(), 0, pDataArray[i]);
				pDataArray[i] = NULL;
			}
		}



		/*for (i=0; i<len; i++)
		{
			if(numbers[i] > 0)
			{
				printf("%d\n", numbers[i]);
			}
		}*/

		delete[] numbers;
		delete[] hThreadArray;
		delete[] dwThreadIdArray;
		delete[] pDataArray;

		failure = 0;

    return failure;
}

DWORD WINAPI MyThreadFunction( LPVOID lpParam )
{
	PMYDATA pDataArray;
	pDataArray = (PMYDATA)lpParam;


	unsigned long k, mult, j;
	for (k=pDataArray->start; k<pDataArray->start+pDataArray->len; k++)
		{
			if(is_prime(numbers[k]) == 1)
			{

				for (j=2*numbers[k]-2;j<pDataArray->len;j+=numbers[k])
				{
					numbers[j] = 0;

				}

			}
			else{numbers[k] = 0;}
		}
	return 0;
}
