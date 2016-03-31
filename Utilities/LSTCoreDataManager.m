//
//  LSTCoreDataManager.m
//
//  Created by Abhinav Singh on 3/31/16.
//

#import "LSTCoreDataManager.h"

@import UIKit;

@interface LSTCoreDataManager () {
	
}

@property(nonatomic, strong) NSManagedObjectContext *objectContext;
@property(nonatomic, strong) NSManagedObjectContext *mainContext;
@property(nonatomic, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property(nonatomic, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation LSTCoreDataManager

-(void)logCountOfObjectsOfClass:(Class)cls {
	
	NSString *name = NSStringFromClass(cls);
	NSLog(@"%@:%@",name, @([self countForObjectsOfClass:name]));
}

- (instancetype)init {
	
	self = [super init];
	if (self) {
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveMainDataBase) name:UIApplicationWillTerminateNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveMainDataBase) name:UIApplicationDidEnterBackgroundNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveMainDataBase) name:UIApplicationWillResignActiveNotification object:nil];
	}
	
	return self;
}

#pragma mark - Inserting Database Objects

-(id)newObjectForClassString:(NSString*)classStr{
	
	return [self newObjectForClassString:classStr andContext:self.objectContext];
}

-(id)newObjectForClassString:(NSString*)classStr andContext:(NSManagedObjectContext*)context{
	
	if (!context) {
		return nil;
	}
	
	NSEntityDescription *entity = [NSEntityDescription entityForName:classStr inManagedObjectContext:context];
	return [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
}

#pragma mark - Retriving Database Objects

-(NSArray *)allObjectMatchingProperty:(NSString*)prop inArray:(NSArray *)dataArray arrayKey:(NSString *)distinctKey ofClass:(NSString *)entity{
	
	NSArray *distinct = [dataArray valueForKeyPath:[NSString stringWithFormat:@"@distinctUnionOfObjects.%@", distinctKey]];
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entity];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ CONTAINS %K", distinct, prop];
	[fetchRequest setPredicate:predicate];
	
	return [self.objectContext executeFetchRequest:fetchRequest error:nil];;
}

-(NSArray*)allObjectsOfClass:(NSString*)className {
	return [self allObjectsOfClass:className predicate:nil sortDescriptor:nil];
}

-(NSArray*)allObjectsOfClass:(NSString*)className predicate:(NSPredicate*)predicate {
	return [self allObjectsOfClass:className predicate:predicate sortDescriptor:nil];
}

-(NSArray*)allObjectsOfClass:(NSString*)className sortDescriptor:(NSSortDescriptor*)sortDescri {
	return [self allObjectsOfClass:className predicate:nil sortDescriptor:sortDescri];
}

- (NSArray*)allObjectsOfClass:(NSString*)className predicate:(NSPredicate*)predicate sortDescriptor:(NSSortDescriptor*)sortDescri{
	return [self allObjectsOfClass:className predicate:predicate sortDescriptor:sortDescri limit:0];
}

-(NSArray*)allObjectsOfClass:(NSString*)className predicate:(NSPredicate*)predicate sortDescriptor:(NSSortDescriptor*)sortDescri limit:(NSInteger)limit{
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	if (limit > 0) {
		[fetchRequest setFetchLimit:limit];
	}
	NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:self.objectContext];
	[fetchRequest setEntity:entity];
	
	if (predicate) {
		[fetchRequest setPredicate:predicate];
	}
	if (sortDescri) {
		[fetchRequest setSortDescriptors:@[sortDescri]];
	}
	
	return [self resultsForFetchRequest:fetchRequest];
}

-(NSArray*)resultsForFetchRequest:(NSFetchRequest*)request {
	
	NSError *error = nil;
	return [self.objectContext executeFetchRequest:request error:&error];
}

-(NSArray*)distinctObjectsOfClass:(NSString*)classNa forProperties:(NSArray*)props {
	
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:classNa];
	fetchRequest.propertiesToFetch = props;
	fetchRequest.returnsDistinctResults = YES;
	
	return [self resultsForFetchRequest:fetchRequest];
}

#pragma mark - Counting

-(NSInteger)countForObjectsOfClass:(NSString*)className {
	
	return [self countForObjectsOfClass:className predicate:nil];
}

-(NSInteger)countForObjectsOfClass:(NSString*)className predicate:(NSPredicate*)predicate{
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:self.objectContext];
	[fetchRequest setEntity:entity];
	
	if (predicate) {
		[fetchRequest setPredicate:predicate];
	}
	
	NSError *error = nil;
	return [self.objectContext countForFetchRequest:fetchRequest error:&error];
}

#pragma mark - Core Data

-(void)saveDataBase {
	
	NSError *error = nil;
	[self.objectContext save:&error];
	if (error) {
		NSLog(@"Error Saving Background Context %@", error);
	}
}

-(void)removeAllScrapObjects {
	
}

-(void)saveMainDataBase {
	
	[self removeAllScrapObjects];
	[self saveDataBase];
	
	NSError *error = nil;
	[self.mainContext save:&error];
	if (error) {
		NSLog(@"Error Saving Main Context %@", error);
	}
	NSLog(@"Main Database saved");
}

-(NSURL *)applicationDocumentsDirectory {
	
	NSURL *documents = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
	return documents;
}

-(NSManagedObjectContext *)objectContext {
	
	if (!_objectContext) {
		_objectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
		[_objectContext setParentContext:self.mainContext];
	}
	return _objectContext;
}

-(NSManagedObjectContext *)mainContext {
	
	if (!_mainContext) {
		NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
		if (coordinator != nil) {
			_mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
			[_mainContext setPersistentStoreCoordinator:coordinator];
		}
	}
	
	return _mainContext;
}

-(NSManagedObjectModel *)managedObjectModel {
	
	// The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
	if (_managedObjectModel != nil) {
		return _managedObjectModel;
	}
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:AppDatabaseName withExtension:@"momd"];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	return _managedObjectModel;
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
	if (!_persistentStoreCoordinator) {
		
		NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:AppDatabaseName];
		NSError *error = nil;
		
		NSFileManager *fileManager = [NSFileManager defaultManager];
		// If the expected store doesn't exist, copy the default store.
		if (![fileManager fileExistsAtPath:[storeURL path]]) {
			NSURL *defaultStoreURL = [[NSBundle mainBundle] URLForResource:AppDatabaseName withExtension:@"sqlite"];
			if (defaultStoreURL) {
				NSError *error = nil;
				[fileManager copyItemAtURL:defaultStoreURL toURL:storeURL error:&error];
				NSLog(@"Error:%@", error);
			}
		}
		
		NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES};
		_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
		if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil
																 URL:storeURL
															 options:options error:&error]) {
			
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		}
	}
	
	return _persistentStoreCoordinator;
}

@end
