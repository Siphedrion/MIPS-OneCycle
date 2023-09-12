unsigned int iterative_factorial_for(unsigned int n) {
    unsigned int result = 1, acum = 0;
    for (unsigned int i = 1; i <= n; i++){
        //result = result * i;
        for (int j = 1; j <= i; j++)
            acum = result + acum;
        result = acum;
        acum = 0;
    }
    return result;
}