classdef Quatd
   properties
       w
       x
       y
       z
   end
   properties (Dependent)
       arr_
   end
   methods
       function self = Quatd(arr)
           self.w = 1.0;
           self.x = 0.0;
           self.y = 0.0;
           self.z = 0.0;
           if nargin == 1
               self.w = arr(1);
               self.x = arr(2);
               self.y = arr(3);
               self.z = arr(4);
           end
       end
       function a = get.arr_(self)
           a = [self.w; self.x; self.y; self.z];
       end
       function self = set.arr_(self, arr)
           self.w = arr(1);
           self.x = arr(2);
           self.y = arr(3);
           self.z = arr(4);
       end
%        function w = get.w(self)
%            w = self.w;
%        end
%        function x = get.x(self)
%            x = self.arr_(2);
%        end
%        function y = get.y(self)
%            y = self.arr_(3);
%        end
%        function z = get.z(self)
%            z = self.arr_(4);
%        end
%        function self = set.w(self, w)
%            self.w = w;
%        end
%        function self = set.x(self, x)
%            self.x = x;
%        end
%        function self = set.y(self, y)
%            self.y = y;
%        end
%        function self = set.z(self, z)
%            self.z = z;
%        end
       function el = elements(self)
           el = self.arr_;
       end
       function q = mtimes(q1, q2)
           q = q1.otimes(q2);
       end
       function q = plus(q1, d)
           q = q1.boxplus(d);
       end
       function d = minus(q1, q2)
           d = q1.boxminus(q2);
       end
       function roll = roll(self)
           roll = atan2(2.0*(self.w*self.x+self.y*self.z),1.0 - 2.0*(self.x*self.x+self.y*self.y));
       end
       function pitch = pitch(self)
           val = 2.0 * (self.w*self.y-self.x*self.z);
           if abs(val) > 1.0
               pitch = sign(val) * pi / 2.0;
           else
               pitch = asin(val);
           end
       end
       function yaw = yaw(self)
           yaw = atan2(2.0*(self.w()*self.z()+self.x()*self.y()), 1.0-2.0*(self.y()*self.y()+self.z()*self.z()));
       end
       function euler = euler(self)
           euler = [self.roll(); self.pitch(); self.yaw()];
       end
       function bar = bar(self)
           bar = self.arr_(2:4,1);
       end
       function R = R(self)
           wx = self.w()*self.x();
           wy = self.w()*self.y();
           wz = self.w()*self.z();
           xx = self.x()*self.x();
           xy = self.x()*self.y();
           xz = self.x()*self.z();
           yy = self.y()*self.y();
           yz = self.y()*self.z();
           zz = self.z()*self.z();
           R = [1 - 2*yy-2*zz, 2*xy + 2*wz, 2*xz - 2*wy;...
               2*xy - 2*wz, 1 - 2*xx - 2*zz, 2*yz + 2*wx;...
               2*xz + 2*wy, 2*yz - 2*wx, 1 - 2*xx - 2*yy];
       end
       function q = normalized(self)
           q = Quatd(self.arr_ / norm(self.arr_));
       end
       function v2 = rota(self, v)
           t = 2.0 * cross(v, self.bar());
           v2 = v - self.w() * t + cross(t, self.bar());
       end
       function v2 = rotp(self, v)
           t = 2.0 * cross(v, self.bar());
           v2 = v + self.w() * t + cross(t, self.bar());
       end
%        function self = invert(self)
%            self.arr_(2:4,1) = -1.0 * self.arr_(2:4,1);
%        end
       function q = inverse(self)
           q = Quatd([self.w() -self.x() -self.y() -self.z()]);
       end
       function q2 = otimes(self, q) 
           w2 = self.w() * q.w() - self.x() * q.x() - self.y() * q.y() - self.z() * q.z();
           x2 = self.w() * q.x() + self.x() * q.w() + self.y() * q.z() - self.z() * q.y();
           y2 = self.w() * q.y() - self.x() * q.z() + self.y() * q.w() + self.z() * q.x();
           z2 = self.w() * q.z() + self.x() * q.y() - self.y() * q.x() + self.z() * q.w();
           q2 = Quatd([w2, x2, y2, z2]);
       end
       function q2 = boxplus(self, delta)
           q2 = self.otimes(Quatd_exp(delta));
       end
       function delta = boxminus(self, q2)
           dq = q2.inverse().otimes(self);
           if dq.w() < 0.0
               dq.arr_ = -1.0 * dq.arr_;
           end
           delta = Quatd_log(dq);
       end
   end
end