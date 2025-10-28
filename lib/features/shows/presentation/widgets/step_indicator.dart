// lib/features/shows/presentation/widgets/step_indicator.dart

import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(
            steps.length,
            (index) => Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _StepDot(
                      isActive: index <= currentStep,
                      isCompleted: index < currentStep,
                      stepNumber: index + 1,
                    ),
                  ),
                  if (index < steps.length - 1)
                    Expanded(
                      child: _StepLine(
                        isActive: index < currentStep,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          steps[currentStep],
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'Step ${currentStep + 1} of ${steps.length}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.5),
              ),
        ),
      ],
    );
  }
}

class _StepDot extends StatelessWidget {
  final bool isActive;
  final bool isCompleted;
  final int stepNumber;

  const _StepDot({
    required this.isActive,
    required this.isCompleted,
    required this.stepNumber,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: BoxShape.circle,
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isCompleted
              ? Icon(
                  Icons.check,
                  size: 18,
                  color: Colors.white,
                  key: ValueKey('check_$stepNumber'),
                )
              : Text(
                  '$stepNumber',
                  style: TextStyle(
                    color: isActive
                        ? Colors.white
                        : Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.4),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  key: ValueKey('number_$stepNumber'),
                ),
        ),
      ),
    );
  }
}

class _StepLine extends StatelessWidget {
  final bool isActive;

  const _StepLine({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}
