function [] = formatted_plot(x_data, y_data, style, x_label, y_label, plot_title)
% Create a tightly-formatted plot with the correct aspect ratio

plot(x_data, y_data, style)
xlim([min(x_data) max(x_data)])
ylim([min(y_data) max(y_data)])
xlabel(x_label)
ylabel(y_label)
pbaspect([range(x_data(1,:)) range(y_data) 1])
title(plot_title)
grid on

end