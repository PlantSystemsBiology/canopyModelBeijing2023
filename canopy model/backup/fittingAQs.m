

function AQfittingOutput_all= fittingAQs()

Date = ["0724","0807","HS"]; % MMDD
Genotype = ["ca1","CA2","F1"]; %
CULTIVAR1 = ["WYJ","WYJ","WYJ"]; % two cultivars
CULTIVAR2 = ["313","314","313314"]; % two cultivars
CULTIVAR3 = ["JY5B","JP69","JYY69"]; % two cultivars

CULTIVAR = CULTIVAR2; % HERE: change to be 1 2 3


AQfittingOutput_all = zeros(0,11);
for c = 1:3
    
    if c == 1
        cultivar = CULTIVAR{c};
    elseif c == 2
        cultivar = CULTIVAR{c};
    elseif c == 3
        cultivar = CULTIVAR{c};
    end
    
    for s = 1:3
        
        
        AQfile = strcat('AQcurves\AQ-',cultivar,'-',Date{s},'-',Genotype{c},'.txt');
        AQfile
        AQdata = importdata(AQfile);
        d = AQdata.data;
        PPFD = d(:,1);
        [row,col]=size(d);
        AQfittingOutput = zeros(col-1, 11);
        AQfittingOutput(:,1) = c;
        AQfittingOutput(:,2) = s;
        AQfittingOutput(:,3) = c;
        
        for n=2:col  % for every single AQ curve
            A = d(:,n);
            Rd_input = A(end,1);
            Rd = -Rd_input;
            [fitresult, gof] = createFit(PPFD, A, Rd);
            AQfittingOutput(n-1,4:end) = [fitresult.Pmax, fitresult.phi, fitresult.theta, Rd,  gof.sse, gof.rsquare, gof.adjrsquare, gof.rmse];
        end
        AQfittingOutput_all = [AQfittingOutput_all;AQfittingOutput];
    end
    
    dlmwrite('AQ_fit_param_313.txt',AQfittingOutput_all,'delimiter','\t','precision', '%.4f');
    % the output filename need to be changed for 
    
end

end

%%

function [fitresult, gof] = createFit(PPFD, A, Rd)
%CREATEFIT(PPFD,A)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : PPFD
%      Y Output: Ac1
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 03-May-2019 21:44:54 自动生成


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData(PPFD, A);

% Set up fittype and options.
eqn = strcat('(phi*x+Pmax-sqrt((phi*x+Pmax)^2-4*theta*phi*x*Pmax))/(2*theta)-',num2str(Rd));
ft = fittype( eqn, 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 0 0.001];
opts.StartPoint = [10 0.5 0.1];
opts.Upper = [80 0.1 1];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

%% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'A vs. PPFD', 'untitled fit 1', 'Location', 'NorthEast' );
%% Label axes
xlabel PPFD
ylabel A


grid on
end


