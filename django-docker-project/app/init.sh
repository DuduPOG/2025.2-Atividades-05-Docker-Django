#!/bin/bash

# Executar migrações
python3 manage.py migrate --noinput

# Criar superusuário se não existir
python3 manage.py shell <<EOF
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', '321')
    print('Superusuário criado com sucesso!')
else:
    print('Superusuário já existe.')
EOF

# Iniciar servidor
python3 manage.py runserver 0.0.0.0:8000