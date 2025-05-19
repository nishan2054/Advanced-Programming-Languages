function outerFunc(){
    let x = 2;
    function innerFunc(){
        console.log("Square value: ", x*x);
    }
    return innerFunc;
}

const run = outerFunc();
run();