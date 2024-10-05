%Adjacency matrix A
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
     0 0 0 0 0 0 0 0 0 1 0]; % City 4 is connected to City 2 and City 3

% Display the original adjacency matrix
disp('Adjacency Matrix A:');
disp(A);

% Compute A^2 (two-step paths)
A2 = A^2;
disp('A^2 (Two-step paths):');
disp(A2);

% Compute A^3 (three-step paths)
A3 = A^3;
disp('A^3 (Three-step paths):');
disp(A3);