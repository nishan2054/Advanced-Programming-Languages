let mean lst =
  let sum = List.fold_left (+) 0 lst in
  float_of_int sum /. float_of_int (List.length lst)

let median lst =
  let sorted = List.sort compare lst in
  let len = List.length sorted in
  if len mod 2 = 0 then
    let a = List.nth sorted (len / 2 - 1)
    and b = List.nth sorted (len / 2) in
    (float_of_int (a + b)) /. 2.0
  else
    float_of_int (List.nth sorted (len / 2))

let mode lst =
  let freq = List.fold_left
    (fun acc x ->
      let count = try List.assoc x acc + 1 with Not_found -> 1 in
      (x, count) :: List.remove_assoc x acc)
    [] lst
  in
  let max_count = List.fold_left (fun acc (_, c) -> max acc c) 0 freq in
  List.filter (fun (_, c) -> c = max_count) freq
  |> List.map fst

let () =
  let data = [4; 2; 2; 8; 3; 3; 3] in
  Printf.printf "Mean: %.2f\n" (mean data);
  Printf.printf "Median: %.2f\n" (median data);
  Printf.printf "Mode(s): ";
  List.iter (Printf.printf "%d ") (mode data);
  print_newline ()
