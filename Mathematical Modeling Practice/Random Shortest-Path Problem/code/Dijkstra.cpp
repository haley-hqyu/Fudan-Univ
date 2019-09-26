#include<iostream>
#include<cstdio>
#include<cstdlib>
#include<cstring>
#include<cmath>
#include<algorithm>
#include<vector>
#include<queue>
#define MAXN 100000
#define INF 0x3f3f3f3f
using namespace std;
struct Edge{
	int from,to,dist;
};
struct HeapNode{
	int d,u;
	bool operator < (const HeapNode &rhs) const{
		return d>rhs.d;
	}
};
vector<int> G[MAXN];
vector<Edge> edges;
bool flag[MAXN];
int d[MAXN],n,m;
void AddEdge(int from,int to,int dist){
	edges.push_back((Edge){from,to,dist});
	G[from].push_back(edges.size()-1);
}
void init(){
	for(int i=0;i<MAXN;++i) G[i].clear();
	edges.clear();
	scanf("%d%d",&n,&m);
	for(int i=1;i<=m;++i){
		int x,y,w;
		scanf("%d%d%d",&x,&y,&w);
		AddEdge(x,y,w);
	}
}
void dijkstra(int s){
	priority_queue<HeapNode> Q;
	memset(d,INF,sizeof(d));
	d[s]=0;
	memset(flag,0,sizeof(flag));
	Q.push((HeapNode){0,s});
	while(!Q.empty()){
		HeapNode x=Q.top();Q.pop();
		int u=x.u;
		if (flag[u]) continue;
		flag[u]=1;
		for(int i=0;i<G[u].size();++i){
			Edge &e=edges[G[u][i]];
			if (d[e.to]>d[u]+e.dist){
				d[e.to]=d[u]+e.dist;
				Q.push((HeapNode){d[e.to],e.to});
			}
		}
	}
}
int main(){
	init();
	dijkstra(1);
	for(int i=1;i<=n;++i) printf("%d ",d[i]);
	return 0;
}
