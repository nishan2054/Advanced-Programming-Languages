def outerFunc():
    x = 2
    def innerFunc():
        print("Square value: ", x*x)
    return innerFunc
run = outerFunc()
run()