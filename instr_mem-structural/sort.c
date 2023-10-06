void sort (int v[], int n){
    int i, j, temp;
    for(i = 0; i < n; i += 1){
        for(j = i-1; j >= 0 && v[j] > v[j+1]; j -= 1){
            temp = v[j];
            v[j] = v[j+1];
            v[j+1] = temp;
        }
    }
}