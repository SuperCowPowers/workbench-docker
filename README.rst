Workbench-Docker
================

**Docker container for the Workbench project.**


Workbench focuses on simplicity, transparency, and easy on-site
customization. As an open source python project it provides light-weight
task management, execution and pipelining for a loosely-coupled set of
python classes.

-  `Workbench <https://github.com/SuperCowPowers/workbench>`_

Workbench Docker Notes
----------------------

Devs
~~~~

- Building: docker build --tag supercowpowers/workbench .
- Committing: docker commit CONTAINER supercowpowers/workbench
- Login: docker login
- Push: docker push supercowpowers/workbench

Users
~~~~~

- Running: docker run --rm --name workbench_demo -p 4242:4242 supercowpowers/workbench
- Getting IP on Mac: boot2docker ip

Notes
~~~~~

- IP: docker ps -q | xargs docker inspect | grep IPAddress | cut -d ‘”‘ -f 4
- Interactive image: docker run -i -t -p 80:80 ubuntu /bin/bash


Read the Documentation
~~~~~~~~~~~~~~~~~~~~~~

Workbench documentation: `Workbench Docs <http://workbench.readthedocs.org/en/latest/>`_

Email Lists (Forums)
~~~~~~~~~~~~~~~~~~~~

-  Users Email List:
   `workbench-users <https://groups.google.com/forum/#!forum/workbench-users>`_
-  Developers Email List:
   `workbench-devs <https://groups.google.com/forum/#!forum/workbench-devs>`_

.. _Workbench_Docs: http://workbench.readthedocs.org/en/latest/
.. _Users_Email_List: https://groups.google.com/forum/#!forum/workbench-users
.. _Developers_Email_List: https://groups.google.com/forum/#!forum/workbench-devs

