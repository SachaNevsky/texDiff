
More useful error messages when there are open environments
at \end{document}.

When an environment is left open, LaTeX gives an error at the
end of the document. However it only informs about the first
of them, while the rest are shown with meaningless errors:

(\end occurred inside a group at level N)

This package replaces them with more useful messages
which show which environments (in reverse order) were
not closed.

That's all. There are no user macros. Just use the package.

License:     MIT
________
Javier Bezos --- http://www.texnia.com





