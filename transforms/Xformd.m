classdef Xformd
    properties
        t
        q
    end
    properties (Dependent)
        arr_
    end
    methods
        function self = Xformd(arr)
            self.t = zeros(3, 1);
            self.q = Quatd_Identity();
            if nargin == 1
                self.t = [arr(1); arr(2); arr(3)];
                self.q = Quatd([arr(4); arr(5); arr(6); arr(7)]);
            end
        end
        function a = get.arr_(self)
            a = [self.t; self.q.elements()];
        end
        function self = set.arr_(self, arr)
            self.t = [arr(1); arr(2); arr(3)];
            self.q.w = arr(4);
            self.q.x = arr(5);
            self.q.y = arr(6);
            self.q.z = arr(7);
        end
        function el = elements(self)
            el = self.arr_;
        end
        function T = mtimes(T1, T2)
            T = T1.otimes(T2);
        end
        function T = plus(T1, d)
            T = T1.boxplus(d);
        end
        function d = minus(T1, T2)
            d = T1.boxminus(T2);
        end
        function H = H(self)
            H = zeros(4, 4);
            H(1:3,1:3) = self.q.R();
            H(1:3,4) = -self.q.R() * self.t;
            H(4,1:3) = zeros(1, 3);
            H(4,4) = 1;
        end
        function T = relativeTo(self, T2)
            TI = Xformd_Identity();
            T = TI.boxplus(self.boxminus(T2));
        end
        function A = Adj(self)
            A = zeros(6,6);
            R = self.q.R();
            A(1:3,1:3) = R;
            A(4:6,4:6) = R;
            A(1:3,4:6) = skew(self.t) * R;
        end
        function T = inverse(self)
            T = Xformd_from_tq(-self.q.rotp(self.t), self.q.inverse());
        end
        function T2 = otimes(self, T)
            tt = 2.0 * cross(T.t, self.q.bar());
            t2 = self.t + T.t - self.q.w()*tt + cross(tt, self.q.bar());
            q2 = self.q.otimes(T.q);
            T2 = Xformd_from_tq(t2, q2);
        end
        function v2 = transforma(self, v)
            v2 = self.q.rota(v) + self.t;
        end
        function v2 = transformp(self, v)
            v2 = self.q.rotp(v - self.t);
        end
        function T2 = boxplus(self, delta)
            T2 = self.otimes(Xformd_exp(delta));
        end
        function delta = boxminus(self, T2)
            T2inv = T2.inverse();
            delta = Xformd_log(T2inv.otimes(self));
        end
    end
end