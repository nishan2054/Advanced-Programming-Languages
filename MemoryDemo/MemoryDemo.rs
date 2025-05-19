fn main() {
    let data = Box::new(vec![1, 2, 3, 4, 5]); // heap allocation via Box
    print(&data); // borrowing
    // data is automatically freed here (ownership goes out of scope)
}

fn print(v: &Vec<i32>) {
    for i in v {
        println!("Rust value: {}", i);
    }
}