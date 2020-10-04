package com.juanma.calculator;

import org.springframework.stereotype.Service;

@Service
public class CalculatorService {
    int sum(int a, int b) {
        return a + b;
    }
}
