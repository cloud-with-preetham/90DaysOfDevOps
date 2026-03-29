# Day 60 – Capstone: Deploy WordPress + MySQL on Kubernetes

## Overview

In this capstone project, we deployed a complete WordPress + MySQL application on Kubernetes using multiple core Kubernetes concepts including Namespace, Secret, ConfigMap, PVC, StatefulSet, Services, Deployment, Resource Limits, Probes, and Horizontal Pod Autoscaler (HPA).

---

## Task 1: Create Namespace

```bash
kubectl create namespace capstone
kubectl config set-context --current --namespace=capstone
kubectl get ns
```

---

## Task 2: Deploy MySQL

### MySQL Secret

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secret
  namespace: capstone
type: Opaque
stringData:
  MYSQL_ROOT_PASSWORD: rootpass
  MYSQL_DATABASE: wordpress
  MYSQL_USER: wpuser
  MYSQL_PASSWORD: wppass
```

Apply:

```bash
kubectl apply -f mysql-secret.yaml
```

### Headless Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mysql
  namespace: capstone
spec:
  clusterIP: None
  ports:
    - port: 3306
      name: mysql
  selector:
    app: mysql
```

### MySQL StatefulSet

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql
  namespace: capstone
spec:
  serviceName: mysql
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
        - name: mysql
          image: mysql:8.0
          ports:
            - containerPort: 3306
          envFrom:
            - secretRef:
                name: mysql-secret
          resources:
            requests:
              cpu: "250m"
              memory: "512Mi"
            limits:
              cpu: "500m"
              memory: "1Gi"
          volumeMounts:
            - name: mysql-storage
              mountPath: /var/lib/mysql
  volumeClaimTemplates:
    - metadata:
        name: mysql-storage
      spec:
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: 1Gi
```

Apply:

```bash
kubectl apply -f mysql-headless.yaml
kubectl apply -f mysql-statefulset.yaml
```

Verify MySQL:

```bash
kubectl exec -it mysql-0 -- mysql -u wpuser -pwppass -e "SHOW DATABASES;"
```

---

## Task 3: Deploy WordPress

### ConfigMap

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: wordpress-config
  namespace: capstone
data:
  WORDPRESS_DB_HOST: mysql-0.mysql.capstone.svc.cluster.local:3306
  WORDPRESS_DB_NAME: wordpress
```

### WordPress Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: wordpress
  namespace: capstone
spec:
  replicas: 2
  selector:
    matchLabels:
      app: wordpress
  template:
    metadata:
      labels:
        app: wordpress
    spec:
      containers:
        - name: wordpress
          image: wordpress:latest
          ports:
            - containerPort: 80
          envFrom:
            - configMapRef:
                name: wordpress-config
          env:
            - name: WORDPRESS_DB_USER
              valueFrom:
                secretKeyRef:
                  name: mysql-secret
                  key: MYSQL_USER
            - name: WORDPRESS_DB_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: mysql-secret
                  key: MYSQL_PASSWORD
          resources:
            requests:
              cpu: "200m"
              memory: "256Mi"
            limits:
              cpu: "500m"
              memory: "512Mi"
          livenessProbe:
            httpGet:
              path: /wp-login.php
              port: 80
            initialDelaySeconds: 60
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /wp-login.php
              port: 80
            initialDelaySeconds: 30
            periodSeconds: 10
```

Apply:

```bash
kubectl apply -f wordpress-config.yaml
kubectl apply -f wordpress-deployment.yaml
```

---

## Task 4: Expose WordPress

```yaml
apiVersion: v1
kind: Service
metadata:
  name: wordpress
  namespace: capstone
spec:
  type: NodePort
  selector:
    app: wordpress
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30080
```

Apply:

```bash
kubectl apply -f wordpress-service.yaml
```

Access:

- Minikube: `minikube service wordpress -n capstone`
- Kind: `kubectl port-forward svc/wordpress 8080:80 -n capstone`

---

## Task 5: Self-Healing and Persistence Test

```bash
kubectl delete pod <wordpress-pod-name>
kubectl delete pod mysql-0
kubectl get pods -n capstone -w
```

Result:

- WordPress pod recreated automatically (Deployment self-healing)
- MySQL pod recreated automatically (StatefulSet self-healing)
- Blog data persisted due to PVC

---

## Task 6: Horizontal Pod Autoscaler

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: wordpress-hpa
  namespace: capstone
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: wordpress
  minReplicas: 2
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50
```

Apply:

```bash
kubectl apply -f wordpress-hpa.yaml
kubectl get hpa -n capstone
```

---

## Architecture Diagram (Logical Flow)

User → NodePort Service → WordPress Deployment → MySQL Headless Service → MySQL StatefulSet → PVC Storage

---

## Concepts Used Mapping

| Concept         | Day Learned |
| --------------- | ----------- |
| Namespace       | Day 61      |
| Deployment      | Day 61      |
| Service         | Day 62      |
| ConfigMap       | Day 63      |
| Secret          | Day 63      |
| PVC             | Day 64      |
| StatefulSet     | Day 65      |
| Probes          | Day 66      |
| Resource Limits | Day 66      |
| HPA             | Day 67      |
| Helm            | Day 68      |

---

## Reflection

**What was hardest:** StatefulSet + WordPress DB connection troubleshooting.

**What clicked:** How all Kubernetes components connect together (Service → Deployment → StatefulSet → Storage).

**What I would add for production:**

- Ingress Controller
- TLS (HTTPS)
- External database
- Backup solution
- Monitoring (Prometheus & Grafana)

---

## Cleanup

```bash
kubectl delete namespace capstone
kubectl config set-context --current --namespace=default
```

---

## Result

Successfully deployed a production-like WordPress + MySQL application on Kubernetes using 12 core Kubernetes concepts with persistence, self-healing, and autoscaling.
