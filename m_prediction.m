function out = m_prediction(x,gamma)
%Model prediction
out = expm(-gamma/x^2);
end