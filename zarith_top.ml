open Printf

let eval_string
      ?(print_outcome = false) ?(err_formatter = Format.err_formatter) str =
  let lexbuf = Lexing.from_string str in
  let phrase = !Toploop.parse_toplevel_phrase lexbuf in
  Toploop.execute_phrase print_outcome err_formatter phrase

let () =
  let printers = ["Z.pp_print"; "Q.pp_print"] in
  let ok = List.fold_left (fun b p ->
               b && eval_string(sprintf "#install_printer %s;;" p))
      true printers in
  if not ok then Format.eprintf "Problem installing ZArith-printers@."
