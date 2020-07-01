function q = Quatd_Random()

arr = rand(1, 4);
arr = arr / norm(arr);
q = Quatd(arr);

end