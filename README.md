# PharmaSUG 2026

Paper AP-228
Timing, Masking, and Resolution: Understanding and Debugging SAS Macros
Carleigh Jo Crabtree, SAS Institute 

# ABSTRACT 

SAS macro processing can produce unexpected results. Having a clear understanding of how and when macro variables are resolved is essential to debugging. This paper examines three foundational concepts essential to writing robust SAS macros: timing, masking, and resolution. Beginning with an overview of the SAS tokenization process and the role of the macro processor, this paper demonstrates how the sequence of macro execution can lead to unintended variable substitution when special characters such as ampersands and percent signs appear within macro variable values. Masking functions %STR and %NRSTR are presented as tools to prevent premature resolution, with attention given to their distinctions and appropriate use cases. This paper further explores how standard macro functions can inadvertently remove character masking during execution, and introduces the "Q" family of macro functions — such as %QUPCASE — as a mechanism for preserving masking through function execution. Annotated code examples and process diagrams are provided throughout to illustrate each concept. Readers will come away with a practical framework for anticipating, diagnosing, and resolving common macro behavior issues in SAS programming.

