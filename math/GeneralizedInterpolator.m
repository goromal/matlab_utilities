classdef GeneralizedInterpolator
    properties
        tdata
        ydata
        method
        n
        i
    end
    methods
        function self = GeneralizedInterpolator(t, y, method)
            self.tdata  = t;
            self.n      = length(self.tdata);
            self.ydata  = y;
            self.method = method;
            self.i      = 0;
        end
        function out = y(self, t)
            if t < self.tdata(1)
                out = self.ydata(1);
                return;
            end
            if t > self.tdata(end)
                out = self.ydata(end);
                return;
            end
            if ismember(t, self.tdata)
                out = self.ydata(self.tdata == t);
                return;
            end
            for idx = 1:1:(self.n-1)
                self.i = idx;
                ti = self.tdata(self.i);
                if ti < t && self.ti(self.i+1) > t
                    out = self.interpy(t);
                    return;
                end
            end
            out = [];
        end
        function out = interpy(self, t)
            if strcmp(self.method, "zero-order-hold")
                out = self.yi(self.i);
            elseif strcmp(self.method, "linear")
                out = self.yi(self.i) + self.dy_lin(t);
            elseif strcmp(self.method, "spline")
                out = self.yi(self.i) + self.dy_spl(t);
            end
        end
        function out = dy_lin(self, t)
            t1 = self.ti(self.i);
            t2 = self.ti(self.i+1);
            y1 = self.yi(self.i);
            y2 = self.yi(self.i+1);
            out = (t-t1)/(t2-t1)*(y2-y1);
        end
        function out = dy_spl(self, t)
            t0 = self.ti(self.i-1);
            t1 = self.ti(self.i);
            t2 = self.ti(self.i+1);
            t3 = self.ti(self.i+2);
            y0 = self.yi(self.i-1);
            y1 = self.yi(self.i);
            y2 = self.yi(self.i+1);
            y3 = self.yi(self.i+2);
            out = (t-t1)/(t2-t1)*((y2-y1) + ...
             (t2-t)/(2*(t2-t1)^2)*(((t2-t)*(t2*(y1-y0)+t0*(y2-y1)-t1*(y2-y0)))/(t1-t0) + ...
             ((t-t1)*(t3*(y2-y1)+t2*(y3-y1)-t1*(y3-y2)))/(t3-t2)));
        end
        function out = yi(self, i)
            if i == 0
                out = self.ydata(1);
            elseif i == self.n+1
                out = self.ydata(end);
            else
                out = self.ydata(i);
            end
        end
        function out = ti(self, i)
            if i == 0
                out = self.tdata(1) - 1.0;
            elseif i == self.n+1
                out = self.tdata(end) + 1.0;
            else
                out = self.tdata(i);
            end
        end
    end
end