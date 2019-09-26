#include<iostream>
#include<cstdio>
#include<cmath>
#include<cstdlib>
#include<cstring>
#include<algorithm>
#include<vector>
#include<queue> 
#define MAXN 110000
#define INF 1000000000 
using namespace std;
struct Edge{
    int from,to,cap,flow;
}; 
int n,m,s,t;
vector<Edge> edges;
vector<int> G[MAXN];
bool vis[MAXN];
int d[MAXN],cur[MAXN],p[MAXN],num[MAXN];
void AddEdge(int from,int to,int cap){
    edges.push_back((Edge){from,to,cap,0});
    edges.push_back((Edge){to,from,0,0});
    m=edges.size();
    G[from].push_back(m-2);
    G[to].push_back(m-1);
} 
void init(){
    int M; 
    scanf("%d%d",&n,&M);
    for (int i=1;i<=M;++i){
        int x,y,w;
        scanf("%d%d%d",&x,&y,&w);
        AddEdge(x,y,w);
    }
}
void BFS(){
    memset(vis,0,sizeof(vis)); 
    queue<int> Q;
    Q.push(t);
    memset(d,0x7f7f7f7f,sizeof(d));
    d[t]=0;
    memset(num,0,sizeof(0));
    num[0]=1;
    vis[t]=1;
    while (!Q.empty()){
        int x=Q.front();
        Q.pop();
        for (int i=0;i<G[x].size();++i){
            Edge e=edges[G[x][i]];
            if (G[x][i]%2==1&&!vis[e.to]){
                Q.push(e.to);
                num[d[e.to]=d[x]+1]++;
                vis[e.to]=1;
            }
        }
    }
} 
int Augment(){
    int x=t,a=INF;
    while (x!=s){
        Edge e=edges[p[x]];
        a=min(a,e.cap-e.flow);
        x=e.from;
    }
    x=t;
    while (x!=s){
        edges[p[x]].flow+=a;
        edges[p[x]^1].flow-=a;
        x=edges[p[x]].from;
    }
    return a;
}
int Maxflow(int ss,int tt){
    s=ss;t=tt;
    int flow=0; 
    BFS();
    memset(p,0,sizeof(p));
    int x=s;
    memset(cur,0,sizeof(cur));
    while(d[s]<n){
        if (x==t){
            flow+=Augment();
            x=s;
        }
        int ok=0;
        for (int i=cur[x];i<G[x].size();++i){
            Edge e=edges[G[x][i]]; 
            if (e.cap>e.flow&&d[x]==d[e.to]+1){
                ok=1;
                p[e.to]=G[x][i];
                cur[x]=i;
                x=e.to;
                break;
            }
        }
        if (!ok){
            int m=n-1;
            for (int i=0;i<G[x].size();++i){
                Edge e=edges[G[x][i]];
                if (e.cap>e.flow) m=min(m,d[e.to]);
            }
            if (--num[d[x]]==0) break;
            num[d[x]=m+1]++;
            cur[x]=0;
            if (x!=s) x=edges[p[x]].from;
        }
    }
    return flow;
}
int main(){
    init();
    printf("%d\n",Maxflow(1,n));
    return 0;
} 