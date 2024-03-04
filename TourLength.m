function L=TourLength(tour,D)

    n=numel(tour);

    
    
    L=0;
    for i=1:n-1
        L=L+D(tour(i),tour(i+1));
    end

end