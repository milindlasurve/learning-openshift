FROM milindlasurve1/cateina:gold
USER root
RUN rm -rf /etc/localtime
RUN  ln -s /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
ENV LICENSE accept
ENV ACE_SERVER_NAME LQM.IXC
ENV MQ_QMGR_NAME LQM.IXC
#ENV ODBCINI /opt/ibm/ace-11/server/ODBC/unixodbc/odbc.ini
#RUN export ODBCINI
#ENV ODBCSYSINI /opt/ibm/ace-11/server/ODBC/unixodbc/
#RUN export ODBCSYSINI
#RUN chown -R mqm:mqm /opt/ibm/ace-11
#RUN rm -rf /opt/ibm/ace-11/server/ODBC/unixodbc/odbc.ini
COPY libmyodbc5a.so /opt/ibm/ace-11/server/ODBC/drivers/lib
COPY libodbcinst.so.2 /opt/ibm/ace-11/server/ODBC/drivers/lib
COPY odbc.ini /opt/ibm/ace-11/server/ODBC/unixodbc/
COPY server.conf.yaml /home/aceuser/ace-server/
RUN chown mqm:mqm /home/aceuser/ace-server/server.conf.yaml
RUN chmod 644 /home/aceuser/ace-server/server.conf.yaml
RUN chown mqm:mqm /opt/ibm/ace-11/server/ODBC/unixodbc/odbc.ini
USER mqm
RUN echo "cd /opt/ibm/ace-11/server/bin; . mqsiprofile" > /home/aceuser/.bashrc
RUN echo "mqsisetdbparms -w /home/aceuser/ace-server/ -n MYSQLDB -u root -p Cateina@1234" >> /home/aceuser/.bashrc
RUN echo "mqsicvp -n MYSQLDB -u root -p Cateina@1234" >> /home/aceuser/.bashrc
