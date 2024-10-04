A = [0 1 0 0 0 0 0 0 0 0 0;
     1 0 1 1 0 0 0 0 0 0 0;
     0 1 0 0 0 0 0 0 0 0 0;
     0 1 0 0 1 1 1 0 0 0 0;
     0 0 0 1 0 0 0 0 0 0 0;
     0 0 0 1 0 0 1 1 0 1 0;
     0 0 0 1 0 1 0 0 0 0 0;
     0 0 0 0 0 1 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 1 0;
     0 0 0 0 0 1 0 0 1 0 1;
     0 0 0 0 0 0 0 0 0 1 0];
% Find the eigenvalues
eigenvalues = eig(A);

% Display the eigenvalues
disp('The eigenvalues are:');
disp(eigenvalues);


% Find the eigenvalues and eigenvectors of matrix A
[V, D] = eig(A);

% V contains the eigenvectors, D contains the eigenvalues in diagonal form
disp('The eigenvectors are:');
disp(V);

disp('The eigenvalues are (in diagonal form):');
disp(D);